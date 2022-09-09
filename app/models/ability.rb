class Ability
  include CanCan::Ability

  def initialize(this_user)
    this_user ||= User.new
    can :manage, Group, user: this_user
    can :manage, Expense, author: this_user
  end
end
