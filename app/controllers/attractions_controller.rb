class AttractionsController < ApplicationController
  def show
    @attractions = Attraction.find(params[:id])
    @markers = {
      lat: attraction.latitude,
      lng: attraction.longitude
    }
  end
end
