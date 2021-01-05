class UserChats < ActiveRecord::Migration[5.2]
  def change
  	create_table :user_chats, :id => false do |t|
  	  t.integer :user_id
      t.integer :chat_id
    end
  end
end
