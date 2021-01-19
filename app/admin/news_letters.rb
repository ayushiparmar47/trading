ActiveAdmin.register NewsLetter do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :subject, :content, :image, :publish, :file
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
    column :file do |fi|
      file_path = "#{fi.file_url}"
      link_to("#{fi.file.identifier}",file_path,target: :_blank)
    end
    column :publish
    column :created_at
  end
  form do |f|
    f.inputs do
      f.input :subject, as: :string
      f.input :content
      f.input :image, :as => :file, :label => "Image", :hint => f.object.image.present? \
        ? link_to("#{f.object&.image&.url}", "#{f.object&.image&.url}", target: :_blank)
        : content_tag(:span, "Please upload Image")
      f.input :file, :as => :file, :label => "File", :hint => f.object.file.present? \
        ? link_to("#{f.object&.file&.url}", "#{f.object&.file&.url}", target: :_blank)
        : content_tag(:span, "Please upload File")
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
      row :file do |fi|
        file_path = "#{fi.file_url}"
        link_to(file_path,file_path,target: :_blank)
      end
      row :publish
    end
  end
  
end
