# frozen_string_literal: true

class Api::V1::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  before_action :authenticate_api_v1_user!, only: [:edit,:update]
  # before_action :configure_account_update_params, only: [:update]
  # before_action :configure_permitted_parameters
  # GET /resource/sign_up
  # def new
  # end

  # POST /api/v1/users
  def create
    # params[:user] = JSON.parse(params["user"])
    user = User.new(email: params[:email], first_name: params[:first_name], image: params[:image], short_bio: params[:short_bio], password: params[:password], referral_code: params[:referral_code],trading_exp: params[:trading_exp])
    if user.save
      token = Tiddle.create_and_return_token(user, request)
      render json: { success: true, user: user.as_json.merge({token: token}), message: "A message with a confirmation link has been sent to your email address. Please follow the link to activate your account."}      
    else
      msg = user.errors.full_messages
      render json: {success: false, message: msg}
    end
  end

  # GET /api/v1/users/edit
  def edit
    if current_api_v1_user.present?
      render_object(current_api_v1_user, 'user', "Edit user details.")
    else
      render_error("Sign in first")
    end
  end

  # PUT /api/v1/users
  def update
    if current_api_v1_user.present?
      current_api_v1_user.update(email: params[:email], first_name: params[:first_name], image: params[:image], short_bio: params[:short_bio])
      if current_api_v1_user.errors.messages.blank?
        if current_api_v1_user.email != params[:email]
          render_object(current_api_v1_user, 'user', "Since you have changed your email, a confirmation mail has been sent to your updated mail id. Please confirm it before proceed.")
        else
          render_object(current_api_v1_user, 'user', "Successfully updated user details.")
        end
      else
        render json: {success: false, user: current_api_v1_user, message: current_api_v1_user.errors.messages}, status: 404
      end
    else
      render json: {success: false, user: current_api_v1_user, message: current_api_v1_user.errors.full_messages.to_sentence}, status: 404
    end
  end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
    # devise_parameter_sanitizer.permit(:user, keys: [:attributes])
  # end
  def user_params
    # devise_parameter_sanitizer.permit(:user, keys: [:email,:password])
    # params.require(:user).permit(:email,:password,:first_name, :image) 
  end


  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
