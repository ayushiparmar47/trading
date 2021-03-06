class AdminAbility
  include CanCan::Ability

  def initialize(user)
    can :read, ActiveAdmin::Page, name: 'Dashboard', namespace_name: 'admin'
    can :manage, :all
    cannot %i[update], NewsLetter.where(publish: true)
    can %i[destroy], PayAmount
    cannot %i[update create], PayAmount
    #cannot %i[destroy], ReferralBonus.where(active: true)
    cannot %i[update create destroy], Subscription
    cannot %i[update create], HistoryTrade
    cannot %i[update create], Payment
  end
end
