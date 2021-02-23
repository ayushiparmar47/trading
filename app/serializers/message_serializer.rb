class MessageSerializer < ActiveModel::Serializer
	attributes :message_id, :body, :message_type, :read_status, :chat_id, :date , :sender_detail
  @hash ={}

  def read_status
    object&.is_mark_read
  end

  def message_id
    object&.id
  end

  def date
    object&.message_date
  end

  def body
    object&.text? ? object&.body : object&.attachment&.url
  end

  def sender_detail
    u = object&.user
    return  @hash = {id: u&.id, name: u&.first_name, image: u&.image&.url}
  end
end
