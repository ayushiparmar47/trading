class AddShortBioToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :short_bio, :text
  end
end
