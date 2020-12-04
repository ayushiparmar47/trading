Rails.application.routes.draw do
	namespace :api, defaults: {format: 'json'} do
		namespace :v1 do
			devise_for :users  		
			resources :users, only: [:index] do
        collection do
          get 'user_details'
        end
      end
      resources :contacts, only: :create
      resources :plans, only: :index 
      resources :companies , only: [:index] 	
      post "/reset_password" => "users#reset_password"      
      post "/set_news_letter" => "users#set_news_letter"		
		end
	end
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
end