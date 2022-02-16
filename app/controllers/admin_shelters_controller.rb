class AdminSheltersController < ApplicationController
  def index
    @pending_apps = Shelter.pending_applications
    @admin_shelters = Shelter.order_reverse_alphaetical
  end
end
