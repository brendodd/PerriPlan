class HotelsController < ApplicationController
  require 'json'
  skip_before_action :authenticate_user!, only: [:show]

  def show
    @hotel = Hotel.find(params[:id])
    @booking = Booking.new
    @review = Review.new
    # @review = Review.find_by(booking_id)
    @city = City.find_by("name LIKE '%#{@hotel.location}%'")

    restaurants = Restaurant.near([@hotel.latitude, @hotel.longitude], 5)

    @markers = restaurants.map do |restaurant|
      {
        lat: restaurant.latitude,
        lng: restaurant.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: { listing: restaurant }),
        type: restaurant.class,
        hotel_marker_html: render_to_string(partial: "cities/hotel_marker"),
        food_marker_html: render_to_string(partial: "cities/food_marker"),
        attr_marker_html: render_to_string(partial: "cities/att_marker")
      }
    end
    @markers << {
      lat: @hotel.latitude,
      lng: @hotel.longitude,
      info_window_html: render_to_string(partial: "info_window", locals: { listing: @hotel }),
      type: @hotel.class,
      hotel_marker_html: render_to_string(partial: "cities/hotel_marker"),
      food_marker_html: render_to_string(partial: "cities/food_marker"),
      attr_marker_html: render_to_string(partial: "cities/att_marker")
    }
  end
end
