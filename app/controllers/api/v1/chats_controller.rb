class Api::V1::ChatsController < ApplicationController
	before_action :authenticate_user!
  before_action :check_user_availablity 
  before_action :find_chat, only: [:read_messages]
  before_action :validate_current_user_chat, only: [:read_messages]
  before_action :check_current_user, only:[:create]
  before_action :check_pagination_params, only: [:chat_list,:chat_list_unread, :history]
 
  def create
  	current_user = User.first
    chat = current_user.chats.where(id: User.find(params['receiver_id']).chats.pluck(:id)).first
    if chat
      chat  
    else
      chat = Chat.create
      second_user = User.find(params['receiver_id'])
      chat.users << second_user
      chat.users << current_user
    end
    render json: {chat_room: chat }
  end
  
  def chat_list
    chats = current_user&.chats.includes(:messages).order('messages.created_at DESC')&.uniq
    chats = chats&.paginate(page: params[:page], per_page: params[:per_page])
      render json: {
       message: 'success',
       data: {
         "chats".to_sym => ActiveModel::Serializer::CollectionSerializer.new(chats, serializer: Api::V1::ChatSerializer, user_id: current_user.id)
     }}, status: :ok
  end
 
   def chat_list_unread
    chats = current_user&.chats.includes(:messages).where.not(messages:{user_id:current_user.id,is_mark_read:true}).order('messages.created_at DESC')&.uniq
    chats = chats.paginate(page: params[:page], per_page: params[:per_page])
    render json: {message: 'success',
       data: {"chats".to_sym => ActiveModel::Serializer::CollectionSerializer.new(chats, serializer: Api::V1::ChatSerializer, unread: 0, user_id: current_user.id)
     }}, status: :ok
   end
 
  def history
    begin
      chat = current_user&.chats&.where(id: User.find(params['receiver_id'])&.chats&.pluck(:id))&.first
      chat_history =  chat&.messages&.order('created_at DESC')
      history = chat_history&.paginate(page: params[:page], per_page: params[:per_page])
      render json: {message: 'success',
         data: {
           "messages".to_sym => ActiveModel::Serializer::CollectionSerializer.new(history, serializer: Api::V1::MessageSerializer)
       }}, status: :ok
      rescue Exception=>e
      render json:{error: "they don't have any chat history"}, status: :Fail
    end
  end
 
  def read_messages
    begin
      @chat.messages&.where&.not(user_id: current_user.id)&.update_all(is_mark_read: params[:is_mark_read] )
       render_message "messages read successfully"
    rescue Exception=> e
      render_error e
    end
  end
   
  private
 
  def check_current_user
    render_error "you are not allowed to create a chat for own" if current_user.id == params['receiver_id'].to_i
  end
 
  def check_chat_live
    @chat =  current_user.chats&.where(is_deleted: "live")
    render_not_found "this chat is no longer exists" and return if @chat.blank?
  end
 
  def find_chat
    @chat = Chat.find_by_id(params[:chat_id])
    render_not_found "chat room is not valid or no longer exists" unless @chat
  end
 
  def validate_current_user_chat
    render_not_found "current user not belong to this chat" unless @chat.users.find_by_id(current_user.id)
  end
  
end
