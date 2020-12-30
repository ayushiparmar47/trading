class User < ApplicationRecord
 
  mount_uploader :image, ImageUploader
  
  APPROVED_DOMAINS =  [
	  "aol.com", "att.net", "comcast.net", "facebook.com", "gmail.com", "gmx.com", "googlemail.com",
	  "google.com", "hotmail.com", "hotmail.co.uk", "mac.com", "me.com", "mail.com", "msn.com",
	  "live.com", "sbcglobal.net", "verizon.net", "yahoo.com", "yahoo.co.uk",
	  "email.com", "fastmail.fm", "games.com", "gmx.net", "hush.com", "hushmail.com", "icloud.com",
	  "iname.com", "inbox.com", "lavabit.com", "love.com", "outlook.com", "pobox.com", "protonmail.ch", "protonmail.com", "tutanota.de", "tutanota.com", "tutamail.com", "tuta.io",
	  "keemail.me", "rocketmail.com", "safe-mail.net", "wow.com", "ygm.com",
	  "ymail.com", "zoho.com", "yandex.com",
	  "bellsouth.net", "charter.net", "cox.net", "earthlink.net", "juno.com",
	  "btinternet.com", "virginmedia.com", "blueyonder.co.uk", "freeserve.co.uk", "live.co.uk",
	  "ntlworld.com", "o2.co.uk", "orange.net", "sky.com", "talktalk.co.uk", "tiscali.co.uk",
	  "virgin.net", "wanadoo.co.uk", "bt.com",
	  "sina.com", "sina.cn", "qq.com", "naver.com", "hanmail.net", "daum.net", "nate.com", "yahoo.co.jp", "yahoo.co.kr", "yahoo.co.id", "yahoo.co.in", "yahoo.com.sg", "yahoo.com.ph", "163.com", "yeah.net", "126.com", "21cn.com", "aliyun.com", "foxmail.com",
	  "hotmail.fr", "live.fr", "laposte.net", "yahoo.fr", "wanadoo.fr", "orange.fr", "gmx.fr", "sfr.fr", "neuf.fr", "free.fr",
	  "gmx.de", "hotmail.de", "live.de", "online.de", "t-online.de", "web.de", "yahoo.de",
	  "libero.it", "virgilio.it", "hotmail.it", "aol.it", "tiscali.it", "alice.it", "live.it", "yahoo.it", "email.it", "tin.it", "poste.it", "teletu.it",
	  "mail.ru", "rambler.ru", "yandex.ru", "ya.ru", "list.ru",
	  "hotmail.be", "live.be", "skynet.be", "voo.be", "tvcablenet.be", "telenet.be",
	  "hotmail.com.ar", "live.com.ar", "yahoo.com.ar", "fibertel.com.ar", "speedy.com.ar", "arnet.com.ar",
	  "yahoo.com.mx", "live.com.mx", "hotmail.es", "hotmail.com.mx", "prodigy.net.mx",
	  "yahoo.ca", "hotmail.ca", "bell.net", "shaw.ca", "sympatico.ca", "rogers.com",
	  "yahoo.com.br", "hotmail.com.br", "outlook.com.br", "uol.com.br", "bol.com.br", "terra.com.br", "ig.com.br", "itelefonica.com.br", "r7.com", "zipmail.com.br", "globo.com", "globomail.com", "oi.com.br"
	]

  has_many :authentication_tokens, dependent: :destroy
  has_many :subscriptions
  has_many :plans, through: :subscriptions, dependent: :destroy
  has_many :user_analyzed_trades
  has_many :referrals, class_name: "User", foreign_key: "referrer_id"
  has_one :wallet

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable,:confirmable ,:token_authenticatable

  # validates :email, presence: true, if: :domain_check
  validates :email, presence: true
  #validates :password, length: { in: 6..20 }, presence: true

  scope :premimum, -> { joins(:plans).where('plans.name LIKE ?', "premimum") }
  scope :free, -> { joins(:plans).where('plans.name LIKE ?', "free") }
  
  after_create :assign_default_wallet

  before_create do |user|
    user.referral_code = generate_unique_key('referral_code')
  end

	def domain_check
		if email.present?
			domain = email.split("@")[1]
			unless APPROVED_DOMAINS.any?(domain)
				errors.add(:email, "is not from a valid domain")
			end
		end
	end

	def generate_password_token!
    self.reset_password_token = generate_token
    self.reset_password_sent_at = Time.now.utc
    save!
  end

  def password_token_valid?
    (self.reset_password_sent_at + 4.hours) > Time.now.utc
  end

  def reset_password!(password)
    self.reset_password_token = nil
    self.password = password
    save!
  end

  def self.similar_profiles(user)
    plan = user.plans.last
    self.joins(:plans).where('plans.name = ? AND users.id != ?', plan.name, user.id)&.limit(6)
  end

  def assign_default_wallet
    self.create_wallet(totel_amount: 0.0)
  end

  private

  def generate_token
    SecureRandom.hex(10)
  end

  def generate_unique_key(field_name)
    loop do
      key = SecureRandom.urlsafe_base64(9).gsub(/-|_/,('a'..'z').to_a[rand(26)])
      break key unless User.exists?("#{field_name}": key)
    end
  end

end
