module ApplicationHelper
  include MarkdownHelper
  include Pagy::Frontend

  # not being used now - <%= pagy_nav_bootstrap(@pagy) if @blog_posts.present? %> in app/views/admin/blog_posts/index.html.erb
  def pagy_nav_bootstrap(pagy)
    pagy_bootstrap_nav(pagy).html_safe
  end
end
