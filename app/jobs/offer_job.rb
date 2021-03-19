class OfferJob < ApplicationJob
  queue_as :default
  
  def perform(plan_offer)
  	plan_offer.update(active: false)
  end

  def max_attempts
    3
  end
  
end
