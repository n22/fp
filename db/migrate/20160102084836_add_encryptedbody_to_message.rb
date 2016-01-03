class AddEncryptedbodyToMessage < ActiveRecord::Migration
  def change
    add_column :messages, :body_encrypted, :string
  end
end
