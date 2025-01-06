class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_post, only: %i[edit update destroy]
  before_action :find_post, only: [:show]

  def index
    @posts = Post.order(created_at: :desc).page(params[:page])
  end

  def show
    @comments = @post.comments
    @comment = Comment.new
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to @post, notice: "Postagem publicada com sucesso!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    unless current_user == @post.user
      redirect_to posts_path, alert: "Você não tem permissão para editar este post."
    end
  end

  def destroy
    if current_user == @post.user
      @post.destroy
      redirect_to posts_path, notice: "Post deletado com sucesso."
    else
      redirect_to posts_path, alert: "Você não tem permissão para deletar este post."
    end
  end

  private

  def set_post
    @post = current_user.posts.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :created_at)
  end

  def find_post
    @post = Post.find(params[:id])
  end
end
