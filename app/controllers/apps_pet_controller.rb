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
  end
end
