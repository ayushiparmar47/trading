class ContactMailer < ApplicationMailer

	def to_admin(contact)
  	@admin = AdminUser.last
  	@contact = contact
    mail to: @admin.email, subject: "Contact mail"
  end

  def to_user(contact)
  	@contact = contact
    mail to: @contact.email, subject: "Contact mail"
  end

end
