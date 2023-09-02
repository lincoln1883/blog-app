module Api
  module V1
    class CommentsController < ApplicationController
      skip_before_action :verify_authenticity_token, only: [:create]

      def index
        @post = Post.find(params[:post_id])
        respond_to do |format|
          format.json { render json: @post.comments }
        end
      end

      def create
        @user = User.find(params[:user_id])
        @post = Post.find(params[:post_id])
        @comment = @post.comments.build(comment_params)
        @comment.author = @user

        if @comment.save
          respond_to do |format|
            format.json { render json: @comment, status: :created }
          end
        else
          respond_to do |format|
            format.json { render json: @comment.errors, status: :unprocessable_entity }
          end
        end
      end

      def comment_params
        params.require(:comment).permit(:text)
      end
    end
  end
end
