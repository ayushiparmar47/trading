ActiveAdmin.register NewsLetter do

  permit_params :subject, :content, :image, :publish
  
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
    actions 
  end

  form do |f|
    f.inputs do
      f.input :subject, as: :string
      f.input :content
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
        image_path = "#{ad.image_url}"
        link_to(image_path, image_path, target: :_blank) 
      end
      row :publish
    end
  end
  
end
