module Api
  module V1
    class PostsController < ApplicationController
      def index
        @user = User.includes(:posts).find(params[:user_id])
        @post = Post.includes(:author, :comments, :likes).where(author_id: @user.id)

        respond_to do |format|
          format.json { render json: @post }
        end
      end
    end
  end
end
