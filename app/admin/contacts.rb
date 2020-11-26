ActiveAdmin.register Contact do
  
  permit_params :name, :email, :phone, :message
  actions :all, :except => [:new, :edit]
  
  index do
    selectable_column
    id_column
    column :name
    column :email
    column :phone
    column :message
    column :replyed
    column :created_at
    actions defaults: true do |contact|
      link_to "Reply", reply_admin_contact_path(contact.id), method: :post
    end
  end
  
  filter :name
  filter :email
  filter :phone
  filter :created_at
  
  show do
    attributes_table do
      row :name
      row :email
      row :phone
      row :message
      row :reply_message if contact.replyed?
      row :created_at
    end
  end

  member_action :reply, method: :post do
    render 'admin/contact/reply'
  end

  member_action :reply_user, method: :post do
    resource.update_attributes(reply_message: params[:dump][:reply_message], replyed: true)
    ContactMailer.to_user(resource).deliver
    flash[:notice] = ('Message sent to user.')
    redirect_to admin_contacts_path
  end
  
end
