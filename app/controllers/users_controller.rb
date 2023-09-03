class UsersController < ApplicationController
  def index
    @user = User.all
  end

  def show
    @user = User.find(params[:id])
    @post = @user.posts
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, flash[:alert] = 'Could not find user'
  end
end
