class SubscriptionExpireJob < Struct.new(:subscription)
  def perform
  	user = subscription.user
  	subscription.destroy
  	user.update(subscribed: false)
  	SubscriptionMailer.expire_mail(user).deliver
  end
end
