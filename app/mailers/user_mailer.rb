class UserMailer < ApplicationMailer
	def sendMail(user)
  	@user = user
    mail to: @user.email, subject: "Change Your password !"
  end
end
