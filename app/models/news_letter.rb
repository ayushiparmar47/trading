class NewsLetter < ApplicationRecord
	mount_uploader :image, ImageUploader

	after_save :send_news_letter

	def send_news_letter
		puts "-------send_news_letter--------"
		if check_field_changed?
			@users = User.where(news_letter: true)
			@users.each do |user|
				#NewsLetterMailer.to_subscriber(mail,self).deliver
				Delayed::Job.enqueue(NewsLetterJob.new(self, user))
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
