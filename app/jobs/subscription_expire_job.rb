class SubscriptionExpireJob < ApplicationJob
  queue_as :default
  
  def perform(subscription)
    user = subscription.user
    subscription.destroy
    user.update(subscribed: false)
    SubscriptionMailer.expire_mail(user).deliver
  end
end
