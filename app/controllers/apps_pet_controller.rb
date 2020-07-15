class AppsPetController < ApplicationController

  def update
    apps_pet = AppsPet.find(params[:id])
    if apps_pet.pet.adoptable?
      apps_pet.update(approved: true)
      puts apps_pet
      redirect_to "/pets/#{apps_pet.pet_id}"
    else
      flash[:error] = "Pet is not adoptable"
      redirect_to "/applications/#{apps_pet.app_id}"
    end
    # @pet = Pet.find(params[:pet_id])
    # app_pet = AppsPet.find(pet_id: @pet.id)
    # applicant = App.find(app_pet).pop
    # if @pet.adoptable?
    #   @pet.update(status: "pending")
    #   @pet.save
    #   app_pet(:approved)
    #   redirect_to "/pets/#{@pet.id}"
    # else
    #   @pet.update(status: "adoptable")
    #   @pet.save
    #   redirect_to "/applications/#{application.id}"
    # end

  end

  private
  def pet_params
    params.permit(:status)
  end
end
