Rails.application.routes.draw do
	namespace :api, defaults: {format: 'json'} do
  		namespace :v1 do
  			devise_for :users
  			# post "/sign_up" => "registrations#create"  		
  			resources :users , only: :index  			
  		end
	end
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
# 