ActiveAdmin.register AdminUser do
  menu parent: "User"

  permit_params :email, :password, :password_confirmation, :name, :phone, :image

  controller do
    def update_resource(object, attributes)
      update_method = attributes.first[:password].present? ? :update_attributes : :update_without_password
      object.send(update_method, *attributes)
    end
  end

  index do
    selectable_column
    id_column
    column :image do |admin_user|
      if admin_user.image.present?
        image_path = "#{admin_user.image_url}"
      else
        image_path = ActionController::Base.helpers.image_url("user.jpeg")
      end
      image_tag image_path  
    end
    column :name
    column :email
    column :phone
    column :created_at
    actions
  end

  filter :name
  filter :email
  filter :phone
  filter :created_at

  form do |f|
    f.inputs do
      f.input :name
      f.input :email
      f.input :phone
      f.input :password
      f.input :password_confirmation
      f.input :image, :as => :file, :label => "Image", :hint => f.object.image.present? \
        ? link_to("#{f.object&.image&.url}", "#{f.object&.image&.url}", target: :_blank)
        : content_tag(:span, "Please upload Image")
      f.input :image_cache, :as => :hidden  
    end
    f.actions
  end

  show do
    attributes_table do
      row :image do |admin_user|
        if admin_user.image.present?
          image_path = "#{admin_user.image_url}"
        else
          image_path = ActionController::Base.helpers.image_url("user.jpeg")
        end
        image_tag image_path  
      end
      row :name
      row :email
      row :phone
      row :created_at
    end
  end

end
