module ApplicationCable
   class ChatChannel < ActionCable::Channel::Base
 
     def subscribed
       stream_from params['channel_name'].to_s
       @params = params
     end
 
      def speak(data)
        url = data["image_url"].present? ? convert_image(data["image_url"]) : nil
        message = Message.create!(body: data['message'], user_id: current_user.id, chat_id: data['chat_id'], message_type: data['message_type'], attachment: url)
          reciever_user = User.find(data['receiver_id'])
 
        data[:message_id] = message.id
 
        ActionCable.server.broadcast(data['channel_name'].to_s, message_id: message.id,body: data['message'], sender_name: current_user.full_name, sender_id: current_user.id, sender_image:current_user.image, message_type:message.message_type,read_status:message.is_mark_read,  date: message.message_date, attachment: message&.attachment&.url)
        MessageBroadcastJob.perform_later message.id 
      end
 
      def receive(data)
        data['read_status'] = Message.find_by_id(data[message_id]).is_mark_read
        ActionCable.server.broadcast(data['channel_name'].to_s, data)
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
end



