class CreateReferalCodes < ActiveRecord::Migration[5.2]
  def change
    create_table :referal_codes do |t|
      t.string :referal_code
      t.float :discount_percent
      t.boolean :active

      t.timestamps
    end
  end
end
