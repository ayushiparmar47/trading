class SubscriptionMailer < ApplicationMailer
	def info(subscription)
  	@user = subscription.user
  	@plan = subscription.plan
  	@subscription = subscription
    mail to: @user.email, subject: "Your plan is about to expier!"
  end

  def expire_mail(user)
  	@user = user
  	mail to: @user.email, subject: "Your plan is expiered!"
  end
end
