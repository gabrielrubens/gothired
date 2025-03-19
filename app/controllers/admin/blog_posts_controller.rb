class Admin::BlogPostsController < ApplicationController
  before_action :authenticate_user! # Ensures only logged-in users can access
  before_action :set_blog_post, only: %i[show edit update destroy]

  def index
    @blog_posts = BlogPost.order(created_at: :desc)
  end

  def show; end

  def new
    @blog_post = BlogPost.new
  end

  def create
    @blog_post = current_user.blog_posts.build(blog_post_params)
    if @blog_post.save
      redirect_to admin_blog_posts_path, notice: "Blog post created successfully!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @blog_post.update(blog_post_params)
      redirect_to admin_blog_posts_path, notice: "Blog post updated successfully!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @blog_post.destroy
    redirect_to admin_blog_posts_path, notice: "Blog post deleted."
  end

  private

  def set_blog_post
    @blog_post = BlogPost.find(params[:id])
  end

  def blog_post_params
    params.require(:blog_post).permit(:title, :slug, :content, :cover_image, :category, :published_at, :featured, tags: [])
  end
end
