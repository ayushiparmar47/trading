# frozen_string_literal: true

class Api::V1::SessionsController < Devise::SessionsController
  skip_before_action :verify_signed_out_user
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /api/v1/users/sign_in
  def create
    # params[:user] = JSON.parse(params[:user])
    email = params[:user][:email]
    if User.find_by_email(email)
      user = User.find_by_email(email)
      if user.confirmed?
        if user.present? && user.valid_password?(params[:user][:password])
          # user = warden.authenticate!(:scope => :user)
          token = Tiddle.create_and_return_token(user, request)
          render json: {success: true, message: "User Successfully Signed in ",user: user.as_json.merge({token: token})}
        else
          render json: {success: false, message: "Email or Password is Invalid"}, status: 404
        end
      else
        render json: {success: false, message: "Please confirm your registered email to access your account."}, status: 401
      end
    else
      render json: {success: false, message: "User is not found "}
    end
  end

  # DELETE /api/v1/users/sign_out
  def destroy
    current_api_v1_user
    if current_api_v1_user && Tiddle.expire_token(current_api_v1_user, request)
      render json: {success: true, status: 200, message: "Successfully Signed Out"}
    else
      render json: { error: 'invalid token', status: 401}
    end
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  private
  
  def verify_signed_out_user
  end
end
