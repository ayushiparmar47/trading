class NewsLetterMailer < ApplicationMailer

	def to_subscriber(letter, user)
		@letter = letter
		@user = user
		mail to: @user.email, subject: @letter.subject
	end

end