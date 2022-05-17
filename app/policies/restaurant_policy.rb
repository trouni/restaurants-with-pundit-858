class RestaurantPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      # scope => contains the Restaurant class, or whatever was passed in `policy_scope`
      scope.where(user: user)
      # scope.where(published: true)
      # scope.all
    end
  end

  ## We don't need this because we are inheriting it from the ApplicationPolicy
  # def new?
  #   create?
  # end

  def create?
    # only admin users can create restaurants
    user.admin?
  end

  def show?
    true
  end

  # def edit?
  #   # I can only edit if I can update the restaurant
  #   update?
  # end

  def update?
    # only the owner of the restaurant can update the restaurant
    user_is_owner?
  end

  def destroy?
    user_is_owner?
  end

  private

  def user_is_owner?
    # record => contains the @restaurant, or whatever was passed in `authorize`
    # user => corresponds to current_user in the controller
    record.user == user # corresponds to restaurant.user == current_user
  end
end
