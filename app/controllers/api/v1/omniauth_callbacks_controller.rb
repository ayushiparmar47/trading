class Api::V1::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :verify_authenticity_token

  def google_oauth2
    handle_oauth
  end

  def facebook
    handle_oauth
  end

  private 

  def handle_oauth
    @user = User.from_omniauth(request.env['omniauth.auth'])
    #@user = User.from_omniauth(params[:access_token])
    if @user.persisted?
      sign_in @user
      if quote_flow?
        redirect_to landing_quote_path(t: "omniauth")
      else
        redirect_to root_path
      end
    else
      redirect_to new_user_registration_url
    end
  end

  def quote_flow?
    origin = request.env['omniauth.origin']
    origin.match(/.*cotizar$/).to_s == origin
  end

end
