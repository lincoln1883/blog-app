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
end
