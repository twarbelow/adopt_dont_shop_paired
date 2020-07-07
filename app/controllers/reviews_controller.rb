class ReviewsController < ApplicationController

  def new
    @shelter = Shelter.find(params[:id])
  end

  def edit
    @review = Review.find(params[:id])
  end
end
