class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Post # start by defining rules for all users, also not logged ones
    return unless user.present?

    can :create, Post
    can :destroy, Post, author_id: user.id # if the user is logged in can manage it's own posts
    can :create, Comment # logged in users can also create comments
    can :destroy, Comment, author_id: user.id
    return unless user.admin?

    can :manage, :all # finally we give all remaining permissions only to the admins
  end
end
