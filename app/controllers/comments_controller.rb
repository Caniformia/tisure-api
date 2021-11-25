class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :update, :destroy]
  before_action :set_comment, only: [:show, :update, :destroy]

  # GET /comments/1
  def show
    render json: @comment
  end

  # POST /questions/1/comments
  def create
    @comment = Comment.new(comment_params)
    @comment.question = Question.find(params[:question_id])
    @comment.user = current_user

    if @comment.save
      render json: @comment, status: :created
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /comments/1
  def update
    if @comment.user != current_user and not current_user.is_admin?
      render json: {}, status: :forbidden
    elsif @comment.update(comment_update_params)
      render json: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /comments/1
  def destroy
    if @comment.user != current_user and not current_user.is_admin?
      render json: {}, status: :forbidden
    else
      @comment.destroy
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:question_id, :content)
    end

    def comment_update_params
      params.require(:comment).permit(:content)
    end
end
