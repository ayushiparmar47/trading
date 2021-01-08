module Api
  module V1
    class MobileDevicesController < ApplicationController
			 #before_action :authenticate_user!

		  # POST /api/mobile_devices
		  def create
		    if !current_user.blank?
		      current_user.mobile_devices.destroy_all
		      @mobile_device = current_user.mobile_devices.build(mobile_device_params)
		      if @mobile_device.save
		        render :show
		      else
		        render json: { errors: @mobile_device.errors }, status: :unprocessable_entity
		      end
		    else
		      render :json => { :message => 'No user found' }, :status => 404
		    end
		  end

		  # DELETE /api/mobile_devices/:id
		  def destroy
		    if !current_user.blank?
		      mobile_device = current_user.mobile_devices.find_by(device_registration_id: params[:id])
		      if !mobile_device.blank? && mobile_device.destroy
		        render json: { success: true, message: "Mobile Registration ID deleted successfully."}
		      else
		        render json: { success: false, message: "Mobile Registration ID delete failed." }, status: :unprocessable_entity
		      end
		    else
		      render :json => { :message => 'No user found' }, :status => 404
		    end
		  end

		  private

		  def mobile_device_params
		    params.permit(:device_registration_id, :device_type)
		  end
		end
	end
end
