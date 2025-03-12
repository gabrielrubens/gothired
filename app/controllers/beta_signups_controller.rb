class BetaSignupsController < ApplicationController
  def create 
    render json: { message: "Success" }, status: :ok
    #respond_to do |format|
    #  format.js { render :create }
    #end
  end
end
