class PostsController < ApplicationController
  def index
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:author_id])
    @post = @user.posts.find(params[:id])
  end
end
