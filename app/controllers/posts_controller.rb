class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
  end

  def create
    @user = User.find(params[:user_id])
    @post = @user.posts.build(posts_params)
    if @post.save
      redirect_to user_path(current_user.id), notice: 'Post was successfully created'
    else
      render :new, status: :unprocessable_entity
      flash[:alert] = 'There was an error saving this post.'
    end
  end

  def new
    @user = User.find(params[:user_id])
    @post = Post.new
  end

  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end

  private

  def posts_params
    params.require(:post).permit(:title, :text)
  end
end
