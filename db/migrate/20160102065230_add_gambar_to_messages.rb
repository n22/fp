class AddGambarToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :gambar, :string
  end
end
