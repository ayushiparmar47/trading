ActiveAdmin.register User do
  permit_params :first_name, :email, :password, :password_confirmation, :image, :news_letter, :short_bio

  index do
    selectable_column
    id_column
    column :first_name
    column :short_bio
    column :email
    column :image do |user|
      image_path = "#{user.image_url}"
      link_to(image_path, image_path, target: :_blank) 
    end
    column :news_letter
    column :current_sign_in_at
    column :created_at
    actions
  end

  filter :first_name
  filter :email
  filter :news_letter
  filter :current_sign_in_at
  filter :created_at

  form do |f|
    f.inputs do
      f.input :first_name
      f.input :short_bio
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :image, :as => :file, :label => "Image", :hint => f.object.image.present? \
        ? link_to("#{f.object&.image&.url}", "#{f.object&.image&.url}", target: :_blank)
        : content_tag(:span, "Please upload Image")
      f.input :image_cache, :as => :hidden    
      f.input :news_letter, as: :boolean
    end
    f.actions
  end

  show do
    attributes_table do
      row :first_name
      row :short_bio
      row :email
      row :image do |user|
        image_path = "#{user.image_url}"
        link_to(image_path, image_path, target: :_blank) 
      end
      row :news_letter
      row :current_sign_in_at
      row :sign_in_count
      row :created_at
    end
  end
  
end
