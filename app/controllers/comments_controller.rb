class CommentsController < ApplicationController

  before_action :set_post

  def index
    @comments = Comment.all
  end

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      flash[:sucess] = "You commented the hell out of that post!"
      redirect_to :back
    else
      flash[:alert] = "Have you thought this through hombre?"
      render root_path
    end
  end

  def destroy
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    flash[:success] = "Your comment has been deleted. Let's hope nobody screenshot it"
    redirect_to root_path
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

end
