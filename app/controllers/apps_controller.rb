class AppsController < ApplicationController
  def new
  end

  def show
    @application = App.find(params[:id])
  end
end
