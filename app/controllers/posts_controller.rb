class PostsController < ApplicationController
  def index
    @user = current_user
  end

  def create
    @user = current_user
    @post = @user.posts.build(posts_params)
    if @post.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
      flash.now[:error] = 'There was an error saving this post.'
    end
  end

  def new
    @user = current_user
    @post = Post.new
  end

  def show
    @user = current_user
    @post = @user.posts.find(params[:post_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, notice: 'The post was not found'
  end

  private

  def posts_params
    params.require(:post).permit(:title, :text)
  end
end
