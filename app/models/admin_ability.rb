class AdminAbility
  include CanCan::Ability

  def initialize(user)
    can :read, ActiveAdmin::Page, name: 'Dashboard', namespace_name: 'admin'
    can :manage, :all
    cannot %i[update], NewsLetter.where(publish: true)
    cannot %i[destroy], PayAmount.where(payed: false)
    cannot %i[destroy], ReferralBonus.where(active: true)
    cannot %i[update create destroy], Subscription
  end
end
