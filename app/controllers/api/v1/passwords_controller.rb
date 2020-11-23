# frozen_string_literal: true

class Api::V1::PasswordsController < Devise::PasswordsController
  before_action :check_valid_token ,only: [:edit]
  # GET /resource/password/new
  def new
    super
    debugger
  end

  # POST /resource/password
  def create
    # super
    debugger
    @user = User.find_by_email(params[:user][:email])
    if @user.present?
     @user.send_reset_password_instructions
     render json: {message: "updated"}
    else
        render json: {message: "no such email is present"}
    end
  end

  # GET /resource/password/edit?reset_password_token=abcdef
  def edit
    debugger
    user = User.find_by_email(params[:email])
    if user.present? && @flag
      
    else

    end
  end


   # user = User.find_by_phone_number(params[:user][:phone_number])
    # if user.present?
    #   if user.otp.to_i == params[:user][:otp].to_i
    #     if  user.valid_password?(params[:user][:new_password]) 
    #       render json: {success: false, message: "New Password should not be the same as Old Password."} 
    #     elsif user.update_attributes!(password: params[:user][:new_password], otp: nil, otp_expiration_time: nil)
    #       render json: {success: true,user: user, message: "Password updated successfully"}
    #     else
    #       render json: {success: false, message: "Error's while updating password."}
    #     end
    #   else
    #     render json: {success: false, message: "Invaild OTP."}
    #   end
    # else
    #   render json: {success: false, message: "Unable to find user"}
    # end



  def reset_my_password

  end
  # PUT /resource/password
  def update
    super
  end
  
  private

  def check_valid_token
    debugger
    @user = User.find_by!(reset_password_token: params[:reset_password_token])
    @flag = true if @user.present?
    rescue ActiveRecord::RecordNotFound
      @flag = false
      # render json: {message: "Inavlid token"}
  end
  protected

  def after_resetting_password_path_for(resource)
    super(resource)
  end

  # The path used after sending reset password instructions
  def after_sending_reset_password_instructions_path_for(resource_name)
    super(resource_name)
  end
end
