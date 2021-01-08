class PushNotificationJob < ApplicationJob
  queue_as :critical

  def perform(receiver_ids, notification_type, data_hash)
    case notification_type
    when 'plan_list'
      send_notification(receiver_ids, 'normal', data_hash)
    end
  end

  def send_notification(receiver_ids, priority, data)
    options = {
      priority: "normal",
      data: data
    #   notification: {
    #     sound: "default",
    #     tag: "instago_notification",
    #     click_action: "com.instago.ui.notification"
    #   }
    }
    event_type = data[:event]["event_type"] || data[:event][:event_type]
    title = "Event"
    case event_type
    when 'plan_list'
      title = "Plan list is successfully displayed."
    end
    options[:data][:body] = title
    registration_ids = MobileDevice.where(user_id: receiver_ids).pluck(:device_registration_id)
    options[:data][:event]["user_id"] = receiver_ids
    if registration_ids.present?
      resp = FCM_CLIENT.send(registration_ids, options)
      puts "SendNotification response: #{resp}"
    else
      puts "SendNotification response: No device registration id for user: #{receiver_ids}"
    end

    # receiver_ids.each do |user_id|
    #   registration_ids = MobileDevice.where(user_id: user_id).pluck(:device_registration_id)
    #   options[:data][:event]["user_id"] = user_id
    #   if registration_ids.present?
    #     resp = FCM_CLIENT.send(registration_ids, options)
    #     puts "SendNotification response: #{resp}"
    #   else
    #     puts "SendNotification response: No device registration id for user: #{user_id}"
    #   end
    # end


  end
end
