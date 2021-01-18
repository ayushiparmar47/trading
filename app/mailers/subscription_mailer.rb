class SubscriptionMailer < ApplicationMailer
	def info(subscription)
  	@user = subscription.user
  	@plan = subscription.plan
  	@subscription = subscription
    mail to: @user.email, subject: "plan subscription"
  end

  def expire_mail(user)
  	@user = user
  	mail to: @user.email, subject: "plan Expired"
  end
end
