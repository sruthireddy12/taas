class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #user ||= User.new # guest user (not logged in)
    if user
      if user.has_role? :super_admin
        can :manage, :all
      elsif user.has_role? :organization_admin, user.organization
        can :manage, User, :organization_id => user.organization_id
        can :manage, Application, :organization_id => user.organization_id
        can :manage, Role, :organization_id => user.organization_id
      else
        can :update, Application do |app|
          !user.find_roles(app.id).map{|r| r.permissions }.flatten.uniq.select { |p| p.subject_class == 'Application' && p.action == 'edit'}.blank?
        end
        can :read, Application do |app|
          !user.find_roles(app.id).map{|r| r.permissions }.flatten.uniq.select { |p| p.subject_class == 'Application' && p.action == 'view'}.blank?
        end
        user_create = !user.roles.map{|r| r.permissions }.flatten.uniq.select { |p| p.subject_class == 'User' && p.action == 'create'}.blank?
        user_delete = !user.roles.map{|r| r.permissions }.flatten.uniq.select { |p| p.subject_class == 'User' && p.action == 'delete'}.blank?
        user_edit = !user.roles.map{|r| r.permissions }.flatten.uniq.select { |p| p.subject_class == 'User' && p.action == 'edit'}.blank?
        can :read, User if user_create == true ||  user_delete == true || user_edit == true
        can :create, User if user_create == true
        can :destroy, User if user_delete == true
        can :update, User if user_edit == true

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
