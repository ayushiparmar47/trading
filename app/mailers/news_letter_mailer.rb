class NewsLetterMailer < ApplicationMailer

	def to_subscriber mail, letter
		@letter = letter
		mail to: mail, subject: @letter.subject
	end

end