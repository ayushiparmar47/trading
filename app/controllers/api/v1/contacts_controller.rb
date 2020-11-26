class Api::V1::ContactsController < ApplicationController
	before_action :authenticate_api_v1_user!

	def create
     contact = Contact.new(contact_params)
     if contact.save
        ContactMailer.to_admin(contact).deliver
        render json: {success: true, message: "Your request sent to our admin. Admin will contact you immediately."}
     else
        msg = contact.errors.full_messages
        render json: {success: false, message: msg}
     end
  end

  protected

  def contact_params
    params.require(:contact).permit(:name, :email, :phone, :message) 
  end

end
