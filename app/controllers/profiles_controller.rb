class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
  end

  def update
    @user = User.find(current_user.id)  # Start with clean instance

    if @user.update(user_params)
      redirect_to profile_path, notice: "Profile updated successfully"
    else
      # Reload the user to ensure the existing attachment is properly loaded
      @user = User.find(current_user.id)
      render :show, status: :unprocessable_entity
    end
  end

  private

  def user_params
    # Returns an empty hash if params[:user] is missing (prevents crash)
    params.fetch(:user, {}).permit(:cv)
  end
end
