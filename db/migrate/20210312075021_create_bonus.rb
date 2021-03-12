class CreateBonus < ActiveRecord::Migration[5.2]
  def change
    create_table :bonus do |t|
    	t.references :user, index: true
    	t.float :amount
    	t.boolean :collected, :default => false
      t.timestamps
    end
  end
end
