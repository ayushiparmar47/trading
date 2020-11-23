class ApplicationController < ActionController::Base
 	# before_action :authenticate_user!
	skip_before_action :verify_authenticity_token
 	protect_from_forgery with: :null_session
 	# before_action :configure_permitted_parameters, if: :devise_controller?


  # protected

  # def configure_permitted_parameters
  #   # devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name])
  #   # devise_parameter_sanitizer.permit(:account_update, keys: [:first_name])
  # end

# private

# Do not generate a session or session ID cookie
# See https://github.com/rack/rack/blob/master/lib/rack/session/abstract/id.rb#L171
	# def do_not_set_cookie
 #  		request.session_options[:skip] = true
	# end
end
