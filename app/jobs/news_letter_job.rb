class NewsLetterJob < ApplicationJob
  queue_as :default

  def perform(news_letter, user)
  	NewsLetterMailer.to_subscriber(news_letter, user).deliver
  end
end
