class ChatSerializer < ActiveModel::Serializer
  attributes :id, :name, :last_message, :message_date, :sender_detail, :read_status, :chat_with_user
  @hash = {}

  def last_message
    msg = set_value
    body = msg&.text? ? msg&.body : msg&.attachment&.url   
    @hash={message_id: msg&.id, message_type: msg&.message_type, body: body, user_id:msg&.user_id, chat_id:msg&.chat_id }
  end

  def message_date
    msg_order&.created_at&.strftime('%d %b %Y, %I:%M%p')
  end
  
  def sender_detail
    u = set_value&.user
    @hash = {id: u&.id, name: u&.first_name, image: u&.image&.url}
  end

  def chat_with_user
    object.users.where.not(id: instance_options[:user_id]).each do |u|
      @hash = {id: u&.id, name: u&.first_name, image: u&.image.url}
    end
    @hash
  end

  def read_status
    set_value&.is_mark_read
  end
 
  def msg_order_status
    msg_desc.where.not(user_id: instance_options[:user_id],  is_mark_read: true).first
  end

  def set_value
    instance_options[:unread].present? ? msg_order_status : msg_order
  end

  def msg_order
    msg_desc&.first
  end

  def msg_desc
    object.messages&.order('messages.created_at DESC')
  end
end