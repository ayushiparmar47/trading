Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'

  # Route Actioncable
  mount ActionCable.server => '/cable'

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
      get 'chat_list', to: 'chats#chat_list'
      get 'unread_chat_list', to: 'chats#unread_chat_list'
      
      resources :payments, only: [:create] do
        collection do
          post :add_payment_method
        end
      end

      resources :user_analyzed_trades do
        collection do
          get 'find_user_analyzed_trades'
        end
      end

      # Mobile device routes
      resources :mobile_devices, only: [:create, :destroy]
      
      resources :contacts, only: :create
      resources :plans, only: :index 
      resources :companies , only: [:index] 
      resources :subscriptions, only:[:create, :destroy] do
        member do 
          post "unsubscribed"
        end
      end
      resources :history_trades , only: [:index] 	
      resources :bonus, only: [:index] do
        collection do
          post 'collect_bonus'
        end
      end
      post "/reset_password" => "users#reset_password"      
      post "/set_news_letter" => "users#set_news_letter"
      get "/get_todays_trades" => "companies#get_todays_trades" 
      post "/set_user_analyzed_trades" => "users#set_user_analyzed_trades"	
      get "/get_user_analyzed_trades" => "users#get_user_analyzed_trades"	
      get "/get_user_info" => "users#get_user_info"
		end
	end
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
end