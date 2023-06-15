class AttractionsController < ApplicationController
  def show
    @attraction = Attraction.find(params[:id])
    @restaurants = Restaurant.near([@attraction.latitude, @attraction.longitude], 2)
    @markers = @restaurants.map do |restaurant|
      {
        lat: restaurant.latitude,
        lng: restaurant.longitude,
        type: 'Restaurant',
        attr_marker_html: render_to_string(partial: "cities/food_marker")
      }
    end
    @hotels = Hotel.near([@restaurant.latitude, @restaurant.longitude], 2)
    @markers << @hotels.map do |hotel|
      { lat: hotel.latitude, lng: hotel.longitude, type: 'Hotel',
        hotel_marker_html: render_to_string(partial: "cities/hotel_marker") }
    end
    @markers << { lat: @attraction.latitude, lng: @attraction.longitude, type: 'Attraction',
                  food_marker_html: render_to_string(partial: "cities/att_marker") }
    @markers.flatten!
    @reviews = @restaurant.reviews
  end
end
