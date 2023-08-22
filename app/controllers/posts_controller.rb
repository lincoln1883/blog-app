class PostsController < ApplicationController
  def index
    @posts = Post.all
    @users = User.find(params[:id])
  end

  def show; end
end
