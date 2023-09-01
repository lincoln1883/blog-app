class CommentsController < ApplicationController
  load_and_authorize_resource
  
  def new
    @user = current_user
    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end

  def create
    @user = current_user
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.author = @user

    if @comment.save
      redirect_to user_posts_url, notice: 'Comment successfully created.'
    else
      render :new, status: :unprocessable_entity
      flash[:alert] = 'There was an error saving this comment.'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      redirect_to user_posts_path(current_user), notice: 'Post was successfully deleted.'
    else
      redirect_to user_posts_path(current_user), alert: 'Failed to delete the post.'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
