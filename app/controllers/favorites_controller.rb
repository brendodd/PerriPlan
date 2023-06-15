class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def index
    @restaurants = current_user.favorited_by_type('Restaurant')
    @hotels = current_user.favorited_by_type('Hotel')
    @attractions = current_user.favorited_by_type('Attraction')

    @listings = []
    @listings << @hotels
    @listings << @attractions
    @listings << @restaurants

    @markers = @listings.flatten.map do |listing|
      {
        loc: listing.location,
        lat: listing.latitude,
        lng: listing.longitude,
        # info_window_html: render_to_string(partial: "info_window", locals: { listing: listing })
      }
    end
  end

  def create
    if params[:hotel_id].present?
      hotel = Hotel.find(params[:hotel_id])
      current_user.favorite(hotel)
    end
    if params[:restaurant_id].present?
      restaurant = Restaurant.find(params[:restaurant_id])
      current_user.favorite(restaurant)
    end
    if params[:attraction_id].present?
      attraction = Attraction.find(params[:attraction_id])
      current_user.favorite(attraction)
    end
  end
end
