class NewsLetterMailer < ApplicationMailer

	def to_subscriber mail, letter
		@letter = letter
		attachments["#{@letter.file.identifier}"] = File.read(@letter.file.path) if @letter.file.present?
		attachments["#{@letter.image.identifier}"] = File.read(@letter.image.path) if @letter.image.present?
		mail(to: mail, subject: @letter.subject)
	end

end