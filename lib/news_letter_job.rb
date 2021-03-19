class NewsLetterJob
  attr_accessor :user, :news_letter

  def initialize news_letter, user
    @news_letter = news_letter
    @user = user
  end

  def perform
  	NewsLetterMailer.to_subscriber(@news_letter, @user).deliver
  end
end
