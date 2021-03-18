class ReferralBonus < ApplicationRecord
	before_save :deactivate_all
	after_save :create_offer_job

  validates :refer_discount, presence: true
  validates :subscriber_discount, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  
  def deactivate_all
    if self.active?
      ReferralBonus.where.not(id: self.id).update_all(active: false) 
    end
  end

  def create_offer_job
  	if self.active?
  		# Delayed::Job.enqueue(OfferJob.new(self), 0, self&.end_date&.getutc)
  	end
  end
end
