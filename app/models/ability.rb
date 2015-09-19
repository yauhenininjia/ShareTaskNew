class Ability
  include CanCan::Ability

  def initialize(user)
    can :destroy, Task, :user_id => user.id
    can :edit, User, :id => user.id
    cannot :answer, Task, :user_id => user.id
  end
end
