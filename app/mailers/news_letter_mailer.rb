class NewsLetterMailer < ApplicationMailer

	def to_subscriber(letter, user)
		@letter = letter
		@user = user
		attachments["#{@letter.file.identifier}"] = File.read(@letter.file.path) if @letter.file.present?
		attachments["#{@letter.image.identifier}"] = File.read(@letter.image.path) if @letter.image.present?
		mail(to: @user.email, subject: @letter.subject)
	end

end