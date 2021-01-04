Rails.application.routes.draw do
	namespace :api, defaults: {format: 'json'} do
		namespace :v1 do
			devise_for :users  		
			resources :users, only: [:index, :show] do
        collection do
          get 'user_details'
          get 'similar_profile'
          get 'invite_user'
          get 'wallet'
        end
      end
      resources :chats
      
      resources :payments, only: [:create] do
        collection do
          post :add_payment_method
        end
      end
      resources :contacts, only: :create
      resources :plans, only: :index 
      resources :companies , only: [:index] 
      resources :subscriptions, only:[:create, :destroy]	
      post "/reset_password" => "users#reset_password"      
      post "/set_news_letter" => "users#set_news_letter"
      get "/get_todays_trades" => "companies#get_todays_trades" 
      post "/set_user_analyzed_trades" => "users#set_user_analyzed_trades"	
      get "/get_user_analyzed_trades" => "users#get_user_analyzed_trades"	
		end
	end
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
end