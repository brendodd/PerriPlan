class RestaurantsController < ApplicationController
  def show
    @restaurant = Restaurant.find(params[:id])
    @attractions = Attraction.near([@restaurant.latitude, @restaurant.longitude], 2)
    @markers = @attractions.map do |attraction|
      {
        lat: attraction.latitude,
        lng: attraction.longitude
      }
    end
    @hotels = Hotel.near([@restaurant.latitude, @restaurant.longitude], 2)
    @markers << @hotels.map { |hotel| { lat: hotel.latitude, lng: hotel.longitude }}
    @markers << { lat: @restaurant.latitude, lng: @restaurant.longitude }
    @markers.flatten!
  end
end
