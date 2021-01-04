ActiveAdmin.register NewsLetter do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :subject, :content, :image, :publish
  #
  # or
  #
  # permit_params do
  #   permitted = [:subject, :content, :image]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  index do
    id_column
    column :subject
    column :content
    column :image do |ad|
      image_path = "#{ad.image_url}"
      link_to(image_path, image_path, target: :_blank) 
    end
    column :publish
    column :created_at
  end
  form do |f|
    f.inputs do
      f.input :subject
      f.input :content, as: :ckeditor
      f.input :image, :as => :file, :label => "Image", :hint => f.object.image.present? \
        ? link_to("#{f.object&.image&.url}", "#{f.object&.image&.url}", target: :_blank)
        : content_tag(:span, "Please upload Image")
      # f.input :image_cache, :as => :hidden    
      f.input :publish, as: :boolean
    end
    f.actions
  end

  show do
    attributes_table do
      row :subject
      row :content
      row :image do |ad|
        # image_tag url_for(ad.image)
        image_path = "#{ad.image_url}"
        link_to(image_path, image_path, target: :_blank) 
      end
      row :publish
    end
  end
  
end
