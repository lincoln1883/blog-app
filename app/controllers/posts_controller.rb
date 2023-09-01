class PostsController < ApplicationController
  before_action :authenticate_user!  
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
