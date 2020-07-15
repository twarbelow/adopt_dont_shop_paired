class AppsController < ApplicationController

  def index
    @pet = Pet.find(params[:id])
  end

  def new
    @favorite_pets
  end

  def show
    @application = App.find(params[:id])
  end

  def create
    new_app = App.new(app_params)
    if new_app.save
      @favorites.favorite_pets.each do |favorite|
      AppsPet.create({pet_id: favorite, app_id: new_app.id})
      end

      @favorites.delete(params[:favorite_ids]) #might be the wrong thing to call here
      session[:favorites] = @favorites.favorite_pets

      flash[:applied] = "Your application for the selected pet has been submitted."
      redirect_to "/favorites"
    else
      flash[:incomplete] = "Application not submitted: Required information missing."
      redirect_to '/applications/new'
    end
  end

  private
  def app_params
    params.permit(:name, :address, :city, :state, :zip, :phone_number, :description)
  end
end
