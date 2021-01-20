class AddFileToNewsletter < ActiveRecord::Migration[5.2]
  def change
    add_column :news_letters, :file, :string
  end
end
