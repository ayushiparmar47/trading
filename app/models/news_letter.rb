class NewsLetter < ApplicationRecord
	mount_uploader :image, ImageUploader
	mount_uploader :file, FileUploader

	validates :subject, presence: true

	after_save :send_news_letter

	def send_news_letter
		puts "-------send_news_letter--------"
		if check_field_changed?
			@users = User.where(news_letter: true)
			@users.each do |user|
				NewsLetterJob.perform_later(self, user)
			end
		end
	end

  def check_field_changed?      
    ["publish"].each do |field|
      return true if (self.send("saved_change_to_#{field}?") and self.publish ) 
    end
    false
  end
  
end
