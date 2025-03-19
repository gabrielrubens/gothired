class BlogController < ApplicationController
  def index
    @blog_posts = BlogPost.order(published_at: :desc).where.not(published_at: nil)
  end

  def show
    @blog_post = BlogPost.find_by!(slug: params[:id])
  end
end
