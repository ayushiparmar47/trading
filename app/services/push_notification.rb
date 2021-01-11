class PushNotification
  def self.trigger_notification(receiver_ids,notification_type, data_hash)
    PushNotificationJob.perform_later(
      receiver_ids,
      notification_type,
      data_hash
    )
  end
end