class ReviewsController < ApplicationController

  def new
    @shelter = Shelter.find(params[:id])
  end

  def create
    @shelter = Shelter.find(params[:id])
    new_review = Review.new(review_params)
    if new_review.save
      redirect_to "/shelters/#{@shelter.id}"
    else
      flash[:notice] = "Review not submitted: Required information missing."
      render :new
    end
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    review = Review.find(params[:id])
    review.update(review_params)
    if review.save
      redirect_to "/shelters/#{review.shelter.id}"
    else
      flash[:notice] = "Missing information from required fields"
      redirect_to "/reviews/#{review.id}/edit"
    end
  end

  def destroy
    review = Review.find(params[:id])
    Review.destroy(params[:id])
    redirect_to "/shelters/#{review.shelter.id}"
  end

  private
  def review_params
    params.permit(:title, :rating, :content, :image_path)
  end

end
