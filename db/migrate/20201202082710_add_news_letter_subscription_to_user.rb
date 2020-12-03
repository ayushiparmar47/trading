class AddNewsLetterSubscriptionToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :news_letter, :boolean
  end
end
