class FavoritesController < ApplicationController
  def index
    @pets = Pet.all
    @favorite_pets =  @favorites.favorite_pets.map { |favorite| Pet.find(favorite) }
  end

  def create
    @favorites.add(params[:id])
    session[:favorites] = @favorites.favorite_pets
    flash[:favorited] = "Pet has been added to your favorites list"
    redirect_to "/pets/#{params[:id]}"
  end

  def destroy
    @favorites.delete(params[:id])
    session[:favorites] = @favorites.favorite_pets
    flash[:unfavorite] = "Pet has been removed from your favorites"
    redirect_to "/favorites"
  end

  def destroy_all
    @favorites.delete_all
    session[:favorites] = @favorites.favorite_pets
    flash[:unfavorite_all] = "All pets have been removed from favorites"
    redirect_to '/favorites'
  end
end
