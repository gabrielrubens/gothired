class JobPostsController < ApplicationController
  before_action :set_job_post, only: [ :show ]
  def index
    @job_posts = JobPost.all
  end

  def show
  end

  def set_job_post
    @job_post = JobPost.find(params[:id])
  end
end
