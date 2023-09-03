class PostsController < ApplicationController
  load_and_authorize_resource

  def index
    @user = User.includes(:comments).find(params[:user_id])
    @user = User.includes(:posts).find(params[:user_id])
    @post = Post.includes(:author, :comments, :likes).where(author_id: @user.id)
  end

  def create
    @post = Post.new(post_params)
    @post.author = current_user
    if @post.save
      redirect_to user_path(current_user.id), notice: 'Post was successfully created'
    else
      flash[:alert] = 'There was an error saving this post.'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.comments.destroy_all
    @post.likes.destroy_all
    if @post.destroy
      redirect_to user_posts_path(current_user), notice: 'Post was successfully deleted.'
    else
      redirect_to user_posts_path(current_user), alert: 'Failed to delete the post.'
    end
  end

  def new
    @post = Post.new
  end

  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :text, :author_id)
  end
end
