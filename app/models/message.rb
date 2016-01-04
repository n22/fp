class Message < ActiveRecord::Base
  belongs_to :conversation
  belongs_to :user
  attr_accessor :content_type, :original_filename, :image_data
  before_save :decode_base64_image
  has_attached_file :image,
  hash_secret: "abc123",
    styles: {
      medium: '300x300>',
      thumb: {
        geometry: '100x100>',
        processor_options: {
          compression: {
            png: false,
            jpeg: '-copy none -optimize'
          }
        }
      }
    },
    processors: [:thumbnail, :compression]
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  attr_encrypted :body, :key => 'a secret key', :attribute => 'body_encrypted'
  validates_presence_of :conversation_id, :user_id
  #attr_encrypted :image, :key => 'a secret key', :attribute => 'image'
  protected
    def decode_base64_image
      if image_data && content_type && original_filename
        decoded_data = Base64.decode64(image_data)
        data = StringIO.new(decoded_data)
        data.class_eval do
          attr_accessor :content_type, :original_filename
        end

        data.content_type = content_type
        data.original_filename = File.basename(original_filename)

        self.image = data
      end
    end

end
