class AppsController < ApplicationController

  def index
    @pet = Pet.find(params[:id])
  end

  def new
  end

  def show
    @application = App.find(params[:id])
  end

  def create
    new_app = App.new(app_params)
    require "pry"; binding.pry
    pets = params[:pet_ids].join(', ')
    if new_app.save
      params[:pet_ids].each do |id|
        @favorites.delete(id)
      end
      flash[:notice] = "Application successfully submitted for #{pets}."
      redirect_to "/favorites"
    else
      flash[:notice] = "Application not submitted: Required information missing."
      render :new
    end
  end

  private
  def app_params
    params.permit(:name, :address, :city, :state, :zip, :phone_number, :description)
  end
end
