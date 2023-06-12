class CitiesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]
  def show
    @hotels = Hotel.all
    @attractions = Attraction.all

    @listings = []
    @listings << @hotels
    @listings << @attractions

    @city = City.find(params[:id])
    @markers = @listings.flatten.map do |listing|
      {
        lat: listing.latitude,
        lng: listing.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: { listing: listing })
      }
    end
  end
end
