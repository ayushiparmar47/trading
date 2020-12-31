class UserMailer < ApplicationMailer
	def sendMail(user)
  	@user = user
    mail to: @user.email, subject: "Change Your password !"
  end

  def invite(user, email, referal_bonus)
  	@user = user
  	@email = email
  	@referal_bonus = referal_bonus
  	mail to: @email, subject: "Invite user !"
  end

end
