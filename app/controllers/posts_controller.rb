class PostsController < ApplicationController
  def index
    @user = User.find(params[:id])
  end

  def create
    @post = current_user.posts.build(posts_params)
    if @post.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
      flash.now[:error] = 'There was an error saving this post.'
    end
  end

  def new
    @post = Post.new
  end

  def show
    @user = current_user
    @post = @user.posts.set_post
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end

  private

  def posts_params
    params.require(:post).permit(:title, :text, :author_id)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
