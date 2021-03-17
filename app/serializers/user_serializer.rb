class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :email, :news_letter, :subscribed, :referral_code, :short_bio, :image, :trading_exp, :referrer_id, :created_at

  has_many :subscriptions
  has_many :plans, through: :subscriptions, dependent: :destroy
  has_many :referrals, class_name: "User", foreign_key: "referrer_id"
  has_one :wallet, dependent: :destroy
 
  def image
  	if object.image.present?
      object.image_url
    else
      ActionController::Base.helpers.image_url("user.jpeg")
    end  
  end

end
