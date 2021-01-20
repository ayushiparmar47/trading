ActiveAdmin.register NewsLetter do

  permit_params :subject, :content, :image, :publish, :file
  
  index do
    id_column
    column :subject
    #column :content
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
    actions 
  end

  form do |f|
    f.inputs do
      f.input :subject, as: :string
      f.input :content, as: :ckeditor, input_html: { ckeditor: { toolbar: 'Full' } }
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
      row :content do |ns|
        ns.content.html_safe
      end
      row :image do |ad|
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
