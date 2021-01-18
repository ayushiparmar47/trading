class OfferJob < Struct.new(:plan_offer)
  def perform
  	plan_offer.update(active: false)
  end

  def max_attempts
    3
  end
  
end