class CreateNewsLetters < ActiveRecord::Migration[5.2]
  def change
    create_table :news_letters do |t|
      t.text :subject
      t.text :content
      t.string :image
      t.boolean :publish
      t.timestamps
    end
  end
end
