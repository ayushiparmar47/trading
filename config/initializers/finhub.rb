# Finhub.configure do |config|
	APP_CONFIG = YAML.load_file(Rails.root.join('config/configuration.yml'))[Rails.env]
# end