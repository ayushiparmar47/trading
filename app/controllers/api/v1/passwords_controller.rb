# frozen_string_literal: true

class Api::V1::PasswordsController < Devise::PasswordsController
  # before_action :check_valid_token ,only: [:edit]
  # before_action :authenticate_api_v1_user!, only: [:reset_password]
  # GET /resource/password/new
  def new
    # super
  end

  # POST /resource/password
  def create
    @user = User.find_by_email(params[:user][:email])
    if @user.present?
      #@user.send_reset_password_instructions
      @user.generate_password_token!
      UserMailer.sendMail(@user).deliver
      render json: {success: true, message: "Reset link sent to your email" , reset_password_token: @user.reset_password_token}, status: 200
    else
      render json: {message: "no such email is present"}
    end
  end

  # GET /resource/password/edit?reset_password_token=abcdef
  def edit
    # redirect to change password screen with reset password token
    render json: {message: "This will redirect to edit password screen wit reset password token"}
  end

  # PUT /api/v1/users/password?reset_password_token=54f8d52628370705e39e
  def update
    token = params[:reset_password_token].to_s
    user = User.find_by(reset_password_token: token)
    if user.present? && user.password_token_valid?
      if params[:user][:password] == params[:user][:confirm_password]
        if user.reset_password!(params[:user][:password])
          render json: { success: true, message: "Your password is successful reset !"}
        else
          render json: { success: false, error: user.errors.full_messages}, status: :unprocessable_entity
        end
      else
        render json: { success: false, error: "Password does not match with confirm password !" }, status: :unprocessable_entity
      end  
    else 
      render json: { success: false, error: "Inavlid token" }, status: :unprocessable_entity 
    end
  end
  
  private

  # def check_valid_token
  # end
  # protected

  # def after_resetting_password_path_for(resource)
  #   super(resource)
  # end

  # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(resource_name)
  #   super(resource_name)
  # end
end
