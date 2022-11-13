class CommentsController < ApplicationController
  def new
    post_id = params[:id]
    comment = Comment.new
    respond_to do |format|
      format.html { render :new, locals: { comment: comment, post_id: post_id } }
    end
  end

  def create
    # new object from params
    @post = Post.find(params[:id])
    @user = User.find(params[:user_id])
    comment = Comment.new(params.require(:comment).permit(:text))
    comment.author = current_user
    comment.post = @post
    # respond_to block
    if comment.save
      redirect_to user_post_path(@user.id, @post.id)
    else
      flash.now[:error] = 'Error: comment could not be saved'
      render :new, locals: { comment: comment }
    end
  end
end
