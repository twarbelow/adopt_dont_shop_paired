class AppsPetController < ApplicationController

  def update_status
  
    @pet = Pet.find(params[:pet_id])
    app_pet = AppsPet.where(pet_id: @pet.id).pluck(:app_id)

    applicant = App.find(app_pet).pop
    if @pet.adoptable?
      @pet.update(status: "pending")
      @pet.save
      redirect_to "/pets/#{@pet.id}"
    else
      @pet.update(status: "adoptable")
      @pet.save
      redirect_to "/applications/#{application.id}"
    end
  end

  private
  def pet_params
    params.permit(:status)
  end
end
