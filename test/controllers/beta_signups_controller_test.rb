require "test_helper"

class BetaSignupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @beta_signups = beta_signups(:one)
  end

  # test "should get create" do
  #   get beta_signups_create_url(@beta_signups)
  #   assert_response :success
  # end

  test "should create beta signup" do
    assert_difference('BetaSignup.count') do
      post beta_signups_url, params: { beta_signup: { email: 'test@example.com' } }, xhr: true
    end
    assert_response :success
  end

end
