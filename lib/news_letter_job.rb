class NewsLetterJob < Struct.new(:news_letter, :user)
  def perform
  	NewsLetterMailer.to_subscriber(news_letter, user).deliver
  end
end