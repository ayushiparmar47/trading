class ReferralBonus < ApplicationRecord
	before_save :deactivate_all
  
  def deactivate_all
    if self.active?
      ReferralBonus.where.not(id: self.id).update_all(active: false) 
    end
  end
end
