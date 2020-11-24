# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!
Rails.application.configure do
	config.action_mailer.default_url_options = { :host => 'desolate-ravine-19733.herokuapp.com' }
end