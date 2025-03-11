require "test_helper"

class BetaSignupsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get beta_signups_create_url
    assert_response :success
  end
end
