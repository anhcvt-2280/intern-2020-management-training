class CommentAbility
  include CanCan::Ability

  def initialize user
    binding.pry
    if user.role_trainer?
      can :manage, :all
    else
      can %i(create destroy), Comment, user_id: user.id
    end
  end
end
