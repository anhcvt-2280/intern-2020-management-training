class Ability
  include CanCan::Ability

  def initialize(user)
    return if user.blank?

    if user.role_trainer?
      can :manage, :all
    else
      can :manage, User, id: user.id
    end
  end
end
