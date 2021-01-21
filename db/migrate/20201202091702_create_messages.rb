class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
    	t.bigint :chat_id
    	t.boolean :is_mark_read
      t.text :body
      t.integer :message_type
      t.string :attachment
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
