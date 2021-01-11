class CreateMobileDevices < ActiveRecord::Migration[5.2]
  def change
    create_table :mobile_devices do |t|
      t.references :user, index: true
      t.string :device_registration_id
      t.integer :device_type
      t.timestamps
    end
  end
end
