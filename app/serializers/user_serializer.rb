class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :email, :news_letter, :subscribed, :plan, :referral_code, :short_bio, :image

  def plan
  	object.plans.last&.name
  end

  def image
  	if object.image.present?
      object.image_url
    else
      ActionController::Base.helpers.image_url("blanck_user.png")
    end  
  end

end
