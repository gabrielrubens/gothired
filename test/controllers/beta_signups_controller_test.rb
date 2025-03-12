require "test_helper"

class BetaSignupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @beta_signups = beta_signups(:one)
  end

  test "should get create" do
    get beta_signups_create_url(@beta_signups)
    assert_response :success
  end
end
