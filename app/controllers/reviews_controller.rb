class ReviewsController < ApplicationController

  def new
    @shelter = Shelter.find(params[:id])
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    review = Review.find(params[:id])
    review.update(review_params)
    redirect_to "/shelters/#{review.shelter.id}"
  end

  private
  def review_params
    params.permit(:title, :rating, :content, :image_path)
  end
end