class Chat < ApplicationRecord
	has_many :messages, dependent: :destroy
  has_and_belongs_to_many :users, join_table: "user_chats"
  enum is_deleted: { disabled: true, live: false }
 
  after_create :create_name
   
  def create_name
    update(name: "channel_name_#{id}")
  end
end
