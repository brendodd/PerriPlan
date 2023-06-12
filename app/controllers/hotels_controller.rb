class HotelsController < ApplicationController
  require 'json'
  skip_before_action :authenticate_user!, only: [:show]

  def show
    @hotel = Hotel.find(params[:id])
    @booking = Booking.new
    @markers = [{
        lat: @hotel.latitude,
        lng: @hotel.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: {hotel: @hotel})
        
    }]

    restaurants = Restaurant.near([@hotel.latitude, @hotel.longitude], 5)

    @markersrestaurants = restaurants.map do |restaurant|
      {
        lat: restaurant.latitude,
        lng: restaurant.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: {restaurant: restaurant})
      }
    end
  end
end
