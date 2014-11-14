class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #user ||= User.new # guest user (not logged in)
    if user
      if user.has_role? :admin
        can :manage, :all
      elsif user.has_role? :admin, user.organization
        can :manage, User, :organization_id => user.organization_id
        can :manage, Application, :organization_id => user.organization_id
      else
        can :update, Application do |app|
          user.is_admin_of? app && app.organization_id == user.organization_id
        end
        can :read, Application do |app|
          user.has_any_role?(:admin, { :name => :admin, :resource => app }, { :name => :user, :resource => app }) && app.organization_id == user.organization_id
        end
      end
    end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
