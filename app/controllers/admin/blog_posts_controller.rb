class Admin::BlogPostsController < ApplicationController
  before_action :authenticate_user! # Ensures only logged-in users can access
  before_action :set_blog_post, only: %i[edit update destroy]

  def index
    @blog_posts = BlogPost.all

    # Filtering by Category
    if params[:category].present? && params[:category] != "All"
      @blog_posts = @blog_posts.where(category: params[:category])
    end

    # Filtering by Tag (Handling JSON column properly)
    if params[:tag].present? && params[:tag] != "All"
      @blog_posts = @blog_posts.where("json_extract(tags, '$') LIKE ?", "%#{params[:tag]}%")
    end

    # Sorting Logic
    case params[:sort]
    when "oldest"
      @blog_posts = @blog_posts.order(created_at: :asc)
    when "alphabetical"
      @blog_posts = @blog_posts.order(title: :asc)
    when "featured"
      @blog_posts = @blog_posts.where(featured: true).order(created_at: :desc)
    else
      @blog_posts = @blog_posts.order(created_at: :desc) # Default: Newest First
    end
  end




  def new
    @blog_post = BlogPost.new
  end

  def create
    @blog_post = current_user.blog_posts.build(blog_post_params)
    puts "PARAMS RECEIVED: #{params.inspect}" # Add this for debugging
    if @blog_post.save
      redirect_to admin_blog_posts_path, notice: "Blog post created successfully!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    @blog_post.slug = blog_post_params[:title].parameterize # Auto-update slug on title change
    puts "PARAMS RECEIVED: #{params.inspect}" # Add this for debugging
    if @blog_post.update(blog_post_params)
      redirect_to admin_blog_posts_path, notice: "Blog post updated successfully!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @blog_post.destroy
    redirect_to admin_blog_posts_path, notice: "Blog post was successfully deleted."
  end

  private

  def set_blog_post
    @blog_post = BlogPost.find(params[:id])
  end

  def blog_post_params
  # params.require(:blog_post).permit(:title, :content, :cover_image, :category, :published_at, :featured, tags: []).tap do |post_params|
  #   post_params[:tags] = post_params[:tags].is_a?(String) ? post_params[:tags].split(",") : post_params[:tags]
  # end
  # def blog_post_params
  params.require(:blog_post).permit(:title, :slug, :content, :cover_image, :category, :published_at, :featured, tags: []).tap do |whitelisted|
      whitelisted[:tags] = params[:blog_post][:tags].split(",").map(&:strip) if params[:blog_post][:tags].is_a?(String)
    end
  end
end
