ActiveAdmin.register ApiToken do
  permit_params :finnhub_api_token, :iexcloud_api_token
  if ApiToken.count == 1
    actions :all, :except => [:destroy,:new]
  else
    actions :all, :except => [:destroy]
  end
end
