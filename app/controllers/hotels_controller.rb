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
  end
end
