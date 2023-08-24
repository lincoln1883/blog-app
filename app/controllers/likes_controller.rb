class LikesController < ApplicationController
  def create
    @user = current_user
    @post = Post.find(params[:post_id])
    @like = @post.likes.build(author_id: @user.id, post_id: @post.id)

    if @like.save
      @like.send(:increment_likes_counter)
      redirect_to user_post_likes_path, notice: 'Success'
    else
      redirect_to root_path, notice: 'Like could not be added'
    end
  end
end
