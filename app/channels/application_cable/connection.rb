module ApplicationCable
  class Connection < ActionCable::Connection::Base
  	identified_by :current_api_v1_user

    def connect
      self.current_api_v1_user = find_verified_user
      logger.add_tags 'ActionCable', current_api_v1_user.email
    end
 
    private
 
    def find_verified_user
      user = User.find_by_email!(request.params['user-email'])
      token = Tiddle::TokenIssuer.build.find_token(user, request.params['auth-token'])
      if token && unexpired?(token)
        touch_token(token)
        user
      else
        reject_unauthorized_connection        
      end
    end
 
    def touch_token(token)
      token.update_attribute(:last_used_at, Time.current) if token.last_used_at < 1.hour.ago
    end

    def unexpired?(token)
      return true unless token.respond_to?(:expires_in)
      return true if token.expires_in.blank? || token.expires_in.zero?
      Time.current <= token.last_used_at + token.expires_in
    end
  end
end


# AuthenticationToken.find_by(body: request.params['auth-token'])

# User.find_by(token: request.params['auth-token'])

# warden.authenticate!p