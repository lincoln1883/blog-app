class UsersController < ApplicationController
  def index
    @user = User.where(id: current_user)
  end

  def show
    @user = current_user
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, notice: 'Record not found'
  end
end
