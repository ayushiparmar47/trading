class CreateContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :contacts do |t|
    	t.string :name
    	t.string :email
    	t.string :phone
    	t.text :message
    	t.text :reply_message
    	t.boolean :replyed, :default => false
      t.timestamps
    end
  end
end
