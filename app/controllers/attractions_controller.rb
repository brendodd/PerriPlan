class AttractionsController < ApplicationController
  def show
    @attraction = Attraction.find(params[:id])
    @restaurants = Restaurant.near([@attraction.latitude, @attraction.longitude], 2)
    @markers = @restaurants.map do |restaurant|
      {
        lat: restaurant.latitude,
        lng: restaurant.longitude
      }
    end
    @hotels = Hotel.near([@attraction.latitude, @attraction.longitude], 2)
    @markers << @hotels.map { |hotel| { lat: hotel.latitude, lng: hotel.longitude }}
    @markers << { lat: @attraction.latitude, lng: @attraction.longitude }
    @markers.flatten!
  end
end
