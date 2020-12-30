class Plan < ApplicationRecord

	enum interval: { day: 0, week: 1, month: 2, year: 3 }

 	has_many :subscriptions
  has_many :users, through: :subscriptions, dependent: :destroy

  validates :name, uniqueness: { case_sensitive: false }
  validates :name, presence: true

end