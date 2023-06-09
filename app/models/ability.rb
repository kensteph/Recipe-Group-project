class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user.present?

    can :read, :all
    can :create, :all
    can :destroy, Recipe do |recipe|
      recipe.user == user
    end

    can :destroy, Food do |food|
      food.user == user
    end

    can :destroy, Inventory do |inventory|
      inventory.user == user
    end

    return unless user.role == 'admin'

    can :manage, :all
  end
end
