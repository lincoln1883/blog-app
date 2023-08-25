class PostsController < ApplicationController
  def index
    @user = current_user
  end

  def create
    @user = current_user
    @post = @user.posts.build(posts_params)
    if @post.save
      redirect_to user_path(current_user.id), notice: 'Post was successfully created'
    else
      render :new, status: :unprocessable_entity
      flash[:alert] = 'There was an error saving this post.'
    end
  end

  def new
    @user = current_user
    @post = Post.new
  end

  def show
    @user = current_user
    @post = @user.posts.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end

  private

  def posts_params
    params.require(:post).permit(:title, :text)
  end
end
