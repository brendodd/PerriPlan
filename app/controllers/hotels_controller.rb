class HotelsController < ApplicationController
  require 'json'
  skip_before_action :authenticate_user!, only: [:show]
  def show
    @hotel = Hotel.find(params[:id])
    @booking = Booking.new
  end
end
