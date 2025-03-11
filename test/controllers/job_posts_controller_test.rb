require "test_helper"

class JobPostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @job_post = job_posts(:one)
  end

  test "should get index" do
    get job_posts_index_url
    assert_response :success
  end

  test "should get show" do
    get job_posts_url(@job_post)
    assert_response :success
  end
end
