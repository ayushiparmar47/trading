class Api::V1::UsersController < ApplicationController
	before_action :authenticate_api_v1_user!, only: [:index,:reset_password,:set_news_letter]
	# get "/api/v1/users"
	def index
		@users = User.all
		render json: {success: true, message: @users}
	end

	def show
		
	end
	# post /api/v1/reset_password
  def reset_password
    params[:user] = JSON.parse(params["user"])
    if current_api_v1_user.present? 
      if (params[:user][:new_password]) == (params[:user][:confirm_password])
        if current_api_v1_user.update(password: params[:user][:new_password]) and current_api_v1_user.errors.blank?
        	render json: {success: true, user: current_api_v1_user.as_json, message: "Password Changed Successfully "}
        else
        	render json: {success: false, error: current_api_v1_user.errors.messages}
        end	
      else
        render json: {success: false, message: "New Password does not match - Confirm Password"}
      end
    else
      render json: {success: false, message: "Sign in first."}
    end
  end

  # POST /api/v1/set_news_letter
  def set_news_letter
    if current_api_v1_user.present? 
      if params[:user][:email].present?
        user = User.find_by_email params[:user][:email]
        if user.present? 
          unless user.news_letter
            if user.update(news_letter: true) and user.errors.blank?
              render json: {success: true, message: "Successfully subscribed."}
            else
              render json: {success: false, message: user.errors.messages}
            end
          else
            render json: {success: false, message: "You have already subscribed"}
          end
        else
          render json: {success: false, message: "user not found with this email."}
        end
      else
        render json: {success: false, message: "Please enter email id."}
      end
    else
      render json: {success: false, message: "Sign in first."}
    end
  end
end
