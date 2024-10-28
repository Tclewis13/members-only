class PostsController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :authenticate_user!, only: [ :index, :show ]
  def new
    @post = Post.new
  end

  def create
    @post = Post.build(allowed_post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to @post
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(allowed_post_params)
      redirect_to @post
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to root_path, status: :see_other
  end

  private

  def allowed_post_params
    params.require(:post).permit(:title, :body)
  end
end
