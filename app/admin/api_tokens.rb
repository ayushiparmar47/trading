ActiveAdmin.register ApiToken do
  permit_params :finnhub_api_token, :iexcloud_api_token
  actions :all, :except => [:destroy]
  
  controller do 
    def create
      @api_tokens = ApiToken.first || ApiToken.new
      @api_tokens.finnhub_api_token = params[:api_token][:finnhub_api_token]
      @api_tokens.iexcloud_api_token = params[:api_token][:iexcloud_api_token]
      if @api_tokens.save
        flash[:notice] = "Saved sucessfully."
      else
        flash[:notice] = "Something went wrong :  #{@api_tokens.errors.full_messages}"
      end
      redirect_to admin_api_tokens_path
    end
  end
end
