ActiveAdmin.register User do
  menu parent: "User"
  permit_params :first_name, :email, :password, :password_confirmation, :image, :news_letter, :short_bio

  scope :all
  scope :premimum
  scope :free

  controller do
    def update_resource(object, attributes)
      update_method = attributes.first[:password].present? ? :update_attributes : :update_without_password
      object.send(update_method, *attributes)
    end
  end

  index do
    selectable_column
    id_column
    column :image do |user|
      if user.image.present?
        image_path = "#{user.image_url}"
      else
        image_path = ActionController::Base.helpers.image_url("user.jpeg")
      end
      image_tag image_path 
    end
    column :first_name
    column :email
    column :plan do |user|
      user.plans.last
    end
    column :referral_code
    column :referral_count do |user|
      user.referrals&.count
    end
    column :wallet do |user|
      "$#{user.wallet&.totel_amount.round(2) rescue nil}"
    end
    column :subscribed
    column :news_letter
    column :created_at
    actions
  end

  filter :first_name
  filter :email
  filter :referral_code
  filter :plans, as: :searchable_select
  filter :created_at

  form do |f|
    f.inputs do
      f.input :first_name
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :image, :as => :file, :label => "Image", :hint => f.object.image.present? \
        ? link_to("#{f.object&.image&.url}", "#{f.object&.image&.url}", target: :_blank)
        : content_tag(:span, "Please upload Image")
      f.input :image_cache, :as => :hidden    
      f.input :short_bio
      f.input :news_letter, as: :boolean
    end
    f.actions
  end

  show do
    attributes_table do
      row :image do |user|
        if user.image.present?
          image_path = "#{user.image_url}"
        else
          image_path = ActionController::Base.helpers.image_url("user.jpeg")
        end
        image_tag image_path  
      end
      row :first_name
      row :short_bio
      row :email
      row :plan do |user|
        user.plans.last
      end
      row :referral_code
      row :referral_user do |user|
        user.referrals.map {|u| u.first_name}
      end
      row :news_letter
      row :subscribed
      row :created_at
    end
  end
  
end
