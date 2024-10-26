class ReviewsController < ApplicationController

  def create
    @band = Band.find(params[:band_id])
    @review = @band.build_review(review_params)
    if @review.save
      redirect_to band_path(@band), notice: 'Review successfully created'
    else
      render 'band#show', status: :unprocessable_entity
    end
  end

  def destroy
    @review = Review.find(params[:id])
    if @review.user == current_user
      @review.destroy
      redirect_to @review.band, notice: 'Review was successfully deleted'
    else
       redirect_to @review.band, alert: 'You are not authorized to delete this review.'
    end
  end
end
