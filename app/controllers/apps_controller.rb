class AppsController < ApplicationController
  def new
  end

  def create
    new_app = App.new(app_params)
    pets = params[:pet_ids].join(', ')
    if new_app.save
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
