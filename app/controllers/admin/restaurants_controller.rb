class Admin::RestaurantsController < ApplicationController
  def index
    @restaurants = policy_scope([:admin, Restaurant])
  end
end
