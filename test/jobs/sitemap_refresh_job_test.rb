require "test_helper"

class SitemapRefreshJobTest < ActiveJob::TestCase
  setup do
    @user = users(:one) # Use fixture user
    @blog_post = BlogPost.create!(
      title: "Unique Test Post",
      slug: "unique-test-post-#{SecureRandom.hex(4)}", # Ensure unique slug
      category: "Test",
      content: "Sample content",
      published_at: Time.zone.now,
      user: @user
    )

    # Use a temporary directory for sitemap files during tests
    SitemapGenerator::Sitemap.public_path = Rails.root.join("tmp/sitemaps")
    FileUtils.rm_rf(SitemapGenerator::Sitemap.public_path)
  end

  teardown do
    FileUtils.rm_rf(SitemapGenerator::Sitemap.public_path)
  end

  test "generates sitemap successfully" do
    assert_performed_jobs 1 do
      SitemapRefreshJob.perform_later
    end

    perform_enqueued_jobs

    sitemap_index = SitemapGenerator::Sitemap.public_path.join("sitemap.xml.gz")
    assert File.exist?(sitemap_index), "Sitemap index file was not created"

    sitemap_content = Zlib::GzipReader.open(sitemap_index).read
    assert_includes sitemap_content, "https://www.gothired.ai/blog/#{@blog_post.slug}"
  end
end
