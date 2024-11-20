class AddChatIdToChat < ActiveRecord::Migration[7.1]
  def change
    add_column :chats, :chat_id, :string, null: false
  end
end
