require "test_helper"

class BlogControllerTest < ActionDispatch::IntegrationTest
  setup do
    @blog_post = blog_posts(:one) # Load from fixtures
  end

  test "should get index" do
    get blog_index_url
    assert_response :success
    assert_select "h5.card-title", @blog_post.title
  end

  test "should get show" do
    get blog_path(@blog_post.slug)
    assert_response :success
    # assert_select "h1", @blog_post.title
  end
end
