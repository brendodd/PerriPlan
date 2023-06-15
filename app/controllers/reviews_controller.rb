class ReviewsController < ApplicationController
  def create
    @booking = Booking.find(params[:booking_id])
    @review = Review.new(review_params)
    @review.booking = @booking
    @review.user = current_user
    if @review.save
      redirect_to hotel_path(@booking.bookable)
    else
      render "cities/show", status: :unprocessable_entity
    end
  end

  def new
    @booking = Booking.find(params[:booking_id])
    @review = Review.new()
  end

  private

  def review_params
    params.require(:review).permit(:comment, :rating)
  end
end
