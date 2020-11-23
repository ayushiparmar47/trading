class Api::V1::UsersController < ApplicationController
	before_action :authenticate_api_v1_user!, only: [:index]
	# get "/api/v1/users"
	def index
		@users = User.all
		render json: {success: true, message: @users}
	end
end
