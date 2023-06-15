class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all
    @markers = @restaurants.geocoded.map do |restaurant|
      {
        lat: restaurant.latitude,
        lng: restaurant.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: { restaurant: restaurant })
      }
    end
  end
  def show
    @booking = Booking.new
    @restaurant = Restaurant.find(params[:id])
    @attractions = Attraction.near([@restaurant.latitude, @restaurant.longitude], 2)
    @markers = @attractions.map do |attraction|
      {
        lat: attraction.latitude,
        lng: attraction.longitude,
        type: 'Attraction',
        attr_marker_html: render_to_string(partial: "cities/att_marker")
      }
    end
    @hotels = Hotel.near([@restaurant.latitude, @restaurant.longitude], 2)
    @markers << @hotels.map do |hotel|
      { lat: hotel.latitude, lng: hotel.longitude, type: 'Hotel',
        hotel_marker_html: render_to_string(partial: "cities/hotel_marker") }
    end
    @markers << { lat: @restaurant.latitude, lng: @restaurant.longitude, type: 'Restaurant',
                  food_marker_html: render_to_string(partial: "cities/food_marker") }
    @markers.flatten!
    @reviews = @restaurant.reviews
  end
end
