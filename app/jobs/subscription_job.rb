class SubscriptionJob < ApplicationJob
  queue_as :default
  
  def perform(subscription)
  	SubscriptionMailer.info(subscription).deliver
  end
end
