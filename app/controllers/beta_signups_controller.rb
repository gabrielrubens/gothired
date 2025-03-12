class BetaSignupsController < ApplicationController
  def create
    
    @beta_signup = BetaSignup.new(beta_signup_params)

    if @beta_signup.save
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js   { render :create }
      end
    else
      respond_to do |format|
        format.html { render "pages/home", status: :unprocessable_entity }
        format.js   { render :create }
      end
    end

  end

  private
  def beta_signup_params
    params.require(:beta_signup).permit(:email)
  end
end
