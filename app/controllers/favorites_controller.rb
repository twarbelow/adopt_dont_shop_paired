class FavoritesController < ApplicationController
  def index
    @pets = Pet.all
  end

  def create
    @favorites.add(params[:id])
    session[:favorites] = @favorites.favorite_pets
    flash[:favorited] = "Pet has been added to your favorites list"
    redirect_to "/pets/#{params[:id]}"
  end
end
