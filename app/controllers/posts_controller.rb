class PostsController < ApplicationController

  before_action :authenticate_user!
  before_action :owned_post, only: [:edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Your post has been created."
      redirect_to posts_path
    else
      flash[:alert] = "Halt, you fiend! You need an image to post here!"
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to(post_path(@post))
    if @post.save
      flash[:success] = "Post updated hombre."
    else
      flash[:alert] = "Something is wrong with your form!"
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
    if @post.destroy
      flash[:success] = "Problem solved! Post deleted."
    else
      flash[:alert] = "Something went wrong. Please try again."
    end
  end

  private

  def post_params
    params.require(:post).permit(:caption, :image)
  end

  def owned_post
    unless current_user == @post.user
      flash[:alert] = "That post doesn't belong to you!"
      redirect_to root_path
    end
  end

end
