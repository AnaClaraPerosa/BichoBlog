class CommentsController < ApplicationController
  before_action :set_post, only: [:create]

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user if user_signed_in?

    if @comment.save
      redirect_to post_path(@post), notice: "Cometário adicionado com sucesso!"
    else
      flash[:alert] = "Comentário não pode ser adicionado!"
      redirect_to post_path(@post), status: :unprocessable_entity
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:content, :anonymous_name)
  end
end
