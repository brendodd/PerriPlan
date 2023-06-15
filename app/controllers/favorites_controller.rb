class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def index
    @favorites = current_user.favorites(restaurants)
    @favorites = current_user.favorites(hotels)
    @favorites = current_user.favorites(attractions)
  end

  def create
    if params[:hotel_id].present?
      hotel = Hotel.find(params[:hotel_id])
      current_user.favorite(hotel)
    end
    if params[:restaurant_id].present?
      restaurant = Restaurant.find(params[:restaurant_id])
      current_user.favorite(hotel)
    end
    if params[:attraction_id].present?
      attraction = Attraction.find(params[:attraction_id])
      current_user.favorite(attraction)
    end
  end
end
