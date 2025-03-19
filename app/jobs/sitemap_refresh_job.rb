class SitemapRefreshJob < ApplicationJob
  queue_as :default

  def perform
    SitemapGenerator::Sitemap.default_host = "https://www.gothired.ai"
    SitemapGenerator::Sitemap.public_path = "public/"
    SitemapGenerator::Sitemap.create do
      add "/", changefreq: "daily", priority: 1.0
      add "/about", changefreq: "weekly", priority: 0.8
      add "/blog", changefreq: "daily", priority: 0.9

      BlogPost.published.find_each do |post|
        add blog_path(post.slug), lastmod: post.updated_at, priority: 0.7
      end
    end

    SitemapGenerator::Sitemap.ping_search_engines
  end
end
