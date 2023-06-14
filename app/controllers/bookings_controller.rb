class BookingsController < ApplicationController
  def new
    @hotel = Hotel.find(params[:hotel_id])
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    @hotel = Hotel.find(params[:hotel_id])
    @booking.bookable = @hotel
    @booking.user = current_user
    if @booking.save
      redirect_to booking_path(@booking)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @booking = Booking.find(params[:id])
  end

  def index
    @current_bookings = current_user.bookings.where(start_time: ..Date.today, end_time: Date.today + 1..)
    @past_bookings = current_user.bookings.where(end_time: ..Date.today - 1)
    @future_bookings = current_user.bookings.where(start_time: Date.today + 1..)
    @review = Review.new()
  end

  private

  def booking_params
    params.require(:booking).permit(:start_time, :end_time, :note)
  end
end
