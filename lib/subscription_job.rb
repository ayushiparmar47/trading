class SubscriptionJob < Struct.new(:subscription)
  def perform
  	SubscriptionMailer.info(subscription).deliver
  end
end
