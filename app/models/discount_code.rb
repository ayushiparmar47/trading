class DiscountCode < ApplicationRecord
	belongs_to :plan
	before_save :deactivate_all

	def deactivate_all
    if self.active?
      DiscountCode.where('id != ? AND plan_id = ?', self.id, self.plan_id).update_all(active: false) 
    end
  end

end
