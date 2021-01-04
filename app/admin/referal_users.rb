ActiveAdmin.register User, as: 'Referral User' do
  actions :all, :except => [:new, :edit, :destroy]

  controller do
    def scoped_collection
      ids = []
      users = User.all
      users.each do |user|
        if user.referrals.present?
          ids << user.id
        end
      end
      User.where(id: ids)
    end
  end

  index do
    selectable_column
    id_column
    column :image do |user|
      if user.image.present?
        image_path = "#{user.image_url}"
      else
        image_path = ActionController::Base.helpers.image_url("blanck_user.png")
      end
      image_tag image_path 
    end
    column :first_name
    column :email
    column :referrals
    column :referral_count do |user|
      user.referrals&.count
    end
    actions
  end

  filter :first_name
  filter :email

  show do
    attributes_table do
      row :image do |user|
        if user.image.present?
          image_path = "#{user.image_url}"
        else
          image_path = ActionController::Base.helpers.image_url("blanck_user.png")
        end
        image_tag image_path  
      end
      row :first_name
      row :email
      h4 "Referral Users"
      div do
        table_for resource.referrals do
          column :id
          column :first_name
          column :email
          column  do |referral|
            span link_to "View", admin_user_path(referral.id)
          end
        end
        h4 "Totel Users:" " #{resource&.referrals&.count}"
      end
    end
  end

end
