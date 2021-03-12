class BonuSerializer < ActiveModel::Serializer
  attributes :id, :amount, :payed_at

  def payed_at
  	object.created_at&.strftime("%a, %d %b %Y AT %H:%M")
  end

end
