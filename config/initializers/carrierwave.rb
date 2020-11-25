if Rails.env.production?
  CarrierWave.configure do |config|
    config.asset_host = 'https://desolate-ravine-19733.herokuapp.com' 
  end
else
	CarrierWave.configure do |config|
    config.asset_host = 'http://localhost:3000' 
  end
end