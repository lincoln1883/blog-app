class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @user = User.includes(:posts, :comments).all
  end

  def show
    @user = User.find(params[:id])
    @post = current_user.posts
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, flash[:alert] = 'Could not find user'
  end
end
