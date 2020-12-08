class Api::V1::CompaniesController < ApplicationController
	def index
		
	end
	def get_company_data_via_webhook
		render json: {success: true,message: "test webhook"},status: 200
	end
end
