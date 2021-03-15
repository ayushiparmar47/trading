
class ChatChannel < ActionCable::Channel::Base

  def subscribed
    stream_from params['channel'].to_s
    @params = params
  end

  def speak(data)
    url = data["image_url"].present? ? convert_image(data["image_url"]) : nil
    message = Message.create!(body: data['message'], user_id: current_api_v1_user.id, chat_id: data['chat_id'], message_type: data['message_type'].to_i, attachment: url)
    
    reciever_user = User.find(data['receiver_id'])

    data[:message_id] = message.id

    ActionCable.server.broadcast(@params['channel'].to_s, message_id: message.id, body: data['message'], sender_name: current_api_v1_user.first_name, sender_id: current_api_v1_user.id, sender_image: current_api_v1_user.image, message_type: message.message_type.to_i, read_status: message.is_mark_read,  date: message.message_date, attachment: message&.attachment&.url)
  end

  def received(data)
    data['read_status'] = Message.find_by_id(data['message_id']).is_mark_read
    ActionCable.server.broadcast(@params['channel'].to_s, data)
  end 

  def convert_image(attachment)
    @content_type, @code_string = attachment.split(",")
    fname ,type = @content_type.split("\;")
    fname = fname.gsub("/",".")
    @code_string = Base64.decode64(@code_string)
    file = File.open(fname, 'wb') and file.write(@code_string)
    file
  end
end


