class Api::V1::UsersController < ApplicationController
	before_action :authenticate_api_v1_user!, only: [:index,:reset_password]
	# get "/api/v1/users"
	def index
		@users = User.all
		render json: {success: true, message: @users}
	end
	# post /api/v1/reset_password
  def reset_password
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
end
