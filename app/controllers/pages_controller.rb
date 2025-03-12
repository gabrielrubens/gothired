class PagesController < ApplicationController
  def home
    @beta_signup = BetaSignup.new
  end
end

# app/controllers/beta_signups_controller.rb
class BetaSignupsController < ApplicationController
  def create
    @beta_signup = BetaSignup.new(beta_signup_params)

    respond_to do |format|
      if @beta_signup.save
        format.turbo_stream { render turbo_stream: turbo_stream.replace("email_form", partial: "beta_signups/success") }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace("email_form", partial: "beta_signups/form", locals: { beta_signup: @beta_signup }) }
      end
    end
  end

  private

  def beta_signup_params
    params.permit(:email)
  end
end
