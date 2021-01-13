ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }
  content title: proc { I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel "Admin User" do
          h1 AdminUser.count
        end
      end
      column do
        panel "User's" do
          h1 User.count
        end
      end
      column do
        panel "Subscriber's" do
          h1 Subscription.count
        end
      end
      column do
        panel "Companies" do
          h1 Company.count
        end
      end
      column do
        panel "Plan's" do
          h1 Plan.count
        end
      end
      column do
        panel "Today Trade" do
          h1 TodayTrade.count
        end
      end
      column do
        panel "User Analyzed Trade" do
          h1 UserAnalyzedTrade.count
        end
      end
    end
    columns do
      column do
        panel "Recent Users" do
          table_for User.order("created_at desc").limit(5) do
            column("Image") do |user|
              if user.image_url.present?
                image_path = "#{user.image_url}"
              else
                image_path = ActionController::Base.helpers.image_url("blanck_user.png")
              end
               image_tag image_path
            end
            column("Name") { |user| link_to(user&.first_name, admin_user_path(user)) }
            column("Email")   { |user| user&.email }
          end
        end
      end
      column do
        panel "Recent Subscriber" do
          table_for Subscription.order("created_at desc").limit(5).each do |subscription|
            column("Image") do |subscription|
              if subscription&.user&.image_url.present?
                image_path = "#{subscription&.user&.image_url}"
              else
                image_path = ActionController::Base.helpers.image_url("blanck_user.png")
              end
               image_tag image_path
            end
            column("Name") { |subscription| link_to(subscription&.user&.first_name, admin_user_path(subscription.user)) }
            column("Plan") { |subscription| link_to(subscription&.plan&.name, admin_plan_path(subscription.plan)) }
            column("Start Date") { |subscription| (subscription&.start_date) }
            column("End Date") { |subscription| (subscription&.end_date) }
          end
        end
      end
    end # columns
  end
end
