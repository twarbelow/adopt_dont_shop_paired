class AppsPetController < ApplicationController

  # def update_status
  #   @pet = Pet.find(params[:pet_id])
  #   app_pet = AppsPet.where(pet_id: @pet.id).pluck(:app_id)
  #
  #   applicant = App.find(app_pet).pop
  #   if @pet.adoptable?
  #     @pet.update(status: "pending")
  #     @pet.save
  #     redirect_to "/pets/#{@pet.id}"
  #   else
  #     @pet.update(status: "adoptable")
  #     @pet.save
  #     redirect_to "/applications/#{application.id}"
  #   end
  # end

  def update_status
    pet = Pet.find(params[:pet_id])

    pet.adoptable?
    pet.save
    if params[:new_status] == "pending"
      pet_application = AppsPet.where(app_id: params[:id], pet_id: params[:pet_id]).first
      pet_application.update(approved: true)
      pet_application.save
      redirect_to "/pets/#{params[:pet_id]}"
    else
      pet_application = AppsPet.where(app_id: params[:id], pet_id: params[:pet_id]).first
      
      pet_application.update(approved: false)
      pet_application.save
      redirect_to "/applications/#{params[:app_id]}"
    end
  end


  private
  def pet_params
    params.permit(:status)
  end
end
