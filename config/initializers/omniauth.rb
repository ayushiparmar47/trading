Rails.application.config.middleware.use OmniAuth::Builder do
	provider :google_oauth2, "125164233177-ce2e33offjqe65su5vsluc642ljrer2v", "H-CMwSIPBU8gOjhYmNOtJRQW"
  provider :facebook, "425232324788191", "3bc4b4c096f10c9d0593e024e0b7607a", { scope: 'email', display: 'popup' }
end
OmniAuth.config.full_host = Rails.env.production? ? 'http://desolate-ravine-19733.herokuapp.com' : 'http://localhost:3000'
