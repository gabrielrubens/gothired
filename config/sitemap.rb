# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://www.example.com"

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end

  # Landing pages
  add "/", changefreq: "daily", priority: 1.0

  # add "/about", changefreq: "weekly"

  # Blog index page
  add "/blog", changefreq: "daily", priority: 0.9

  # Dynamic blog posts
  BlogPost.find_each do |post|
    add blog_path(post.slug), lastmod: post.updated_at, changefreq: "weekly", priority: 0.8
  end
end
