class Message < ActiveRecord::Base
  belongs_to :conversation
  belongs_to :user
  
  attr_encrypted :body, :key => 'a secret key', :attribute => 'body_encrypted'
  validates_presence_of :body, :conversation_id, :user_id
end
