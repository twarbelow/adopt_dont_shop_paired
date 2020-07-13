class AppsController < ApplicationController

  def index
    @pet = Pet.find(params[:id])
  end

  def new
  end

  def show
    @application = App.find(params[:id])
  end
end
