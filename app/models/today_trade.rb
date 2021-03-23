class TodayTrade < ApplicationRecord
  belongs_to :company

  after_create :add_history
  # attr_accessor :plan_ids
  validates :company, presence: true
  # validates :plans, presence: true
  has_many :trade_plans, dependent: :destroy
  has_many :plans, through: :trade_plans
  accepts_nested_attributes_for :plans
  # validates :company, :presence => {:message => "Company can't be blank." }
  # validates :plans, :presence => {:message => "Plans can't be blank." }
  # before_save do |model|
  #   model.plans.reject!(&:blank?)
  # end

  def add_history
  	HistoryTrade.create(company_name: self.company&.name, symbol: self.company&.symbol, plans: self.plans.pluck(:id))
  end

end
