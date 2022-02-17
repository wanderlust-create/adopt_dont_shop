class AdminSheltersController < ApplicationController
  def index
    @pending_apps = Shelter.pending_applications
    @admin_shelters = Shelter.order_reverse_alphaetical
  end

  def show
    @applicant = Application.find(params[:id])
  end

  def update
    choosen_pet = Pet.find(params[:pet_id])
  end

end
