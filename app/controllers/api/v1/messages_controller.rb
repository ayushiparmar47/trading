class Api::V1::MessagesController < ApplicationController
	before_action :find_chat, only: [:create]
  after_action :convert
  require "base64"

  def create
    @m = @chat.messages.create!(params_message)
  end 

  private

  def params_message
    params.permit(:account_id, :message_type, :attachment,:body)
  end
      
  def convert
    if params[:attachment].present?
      @content_type, @code_string = params[:attachment].split(",")
      fname ,type = @content_type.split("\;")
      fname = fname.gsub("/",".")
      @code_string = Base64.decode64(@code_string)
      file = File.open(fname, 'wb') and file.write(@code_string)
      @m.attachment = file
      @m.save
    end
  end

  def find_chat
    @chat = Chat.find(params[:chat_id])
  end
end
