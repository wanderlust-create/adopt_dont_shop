class AdminSheltersController < ApplicationController
  def index
    @pending_apps = Shelter.pending_applications
    @admin_shelters = Shelter.order_reverse_alphaetical
  end

  def show
    # require "pry"; binding.pry
    @applicant = Application.find(params[:id])
  end

end
