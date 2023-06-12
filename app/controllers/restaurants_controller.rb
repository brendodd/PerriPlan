class RestaurantsController < ApplicationController
  def show
    @restaurants = Restaurant.find(params[:id])
  end
end
