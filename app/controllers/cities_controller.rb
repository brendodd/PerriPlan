class CitiesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]
  def show
    @city = City.find(params[:id])
    @hotels = Hotel.all
    @markers = @hotels.geocoded.map do |hotel|
      {
        lat: hotel.latitude,
        lng: hotel.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: {hotel: hotel})
      }
    end
  end
end
