module ApplicationCable
  class Connection < ActionCable::Connection::Base
  	identified_by :current_user
    def connect
      self.current_user = find_verified_user
      logger.add_tags 'ActionCable', current_user.email
    end
 
    private
 
    def find_verified_user
      @token = AuthenticationToken.find_by(body: request.headers['auth-token'])
      if current_user = @token.user
        current_user
      else
        reject_unauthorized_connection
      end
    end
 
  end
end
