class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chat
  enum message_type: { text: 0,  file: 1 }
  validates :body, presence: true, unless: :attachment
  validates :attachment, presence: true, unless: :body
  mount_uploader :attachment, ImageUploader

  def message_date
    created_at&.strftime('%d %b %Y, %I:%M%p')
  end

end
