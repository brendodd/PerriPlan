class BookingsController < ApplicationController
  def new
    @hotel = Hotel.find(params[:hotel_id])
    @booking = Booking.new
  end

  def create
  end
end
