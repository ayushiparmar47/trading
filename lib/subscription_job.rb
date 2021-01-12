class SubscriptionJob < Struct.new(:subscription)
  def perform
    # mailing = Mailing.find(mailing_id)
    # mailing.deliver
  end
end