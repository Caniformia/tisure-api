class QuestionListsController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_question_list, only: [:show, :update, :destroy]
  before_action :authenticate_list_modify, only: [:update, :destroy]
  before_action :authenticate_list_show, only: [:show]

  # GET /question_lists
  def index
    render json: current_user.question_lists
  end

  # GET /question_lists/1
  def show
    render json: @question_list
  end

  # POST /question_lists
  def create
    @question_list = QuestionList.new(question_list_params)
    @question_list.owner = current_user

    if @question_list.forked_from
      @question_list.forked_from.question_list_items.each do |rec|
        @question_list.questions << rec.question
      end
      if @question_list.forked_from.owner == current_user
        @question_list.forked_from = nil
      elsif @question_list.forked_from.visibility_private?
        render json: {}, status: :forbidden
        return
      end
    end

    if @question_list.save
      render json: @question_list, status: :created, location: @question_list
    else
      render json: @question_list.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /questions/1
  def update
    if params[:visibility] != 'public' and QuestionList.where(forked_from: @question_list)
      render json: {}, status: :unprocessable_entity
    elsif @question_list.update(question_list_update_params)
      render json: @question_list
    else
      render json: @question_list.errors, status: :unprocessable_entity
    end
  end

  # DELETE /question_lists/1
  def destroy
    @question_list.destroy
  end

  private
    def authenticate_list_modify
      unless @question_list.owner == current_user || current_user.is_admin?
        render json: {}, status: :forbidden
      end
    end

    def authenticate_list_show
      unless @question_list.visibility_public? || @question_list.owner == current_user || current_user.is_admin?
        render json: {}, status: :forbidden
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_question_list
      @question_list = QuestionList.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def question_list_params
      params.require(:question_list).permit(:name, :visibility, :forked_from_id)
    end

    def question_list_update_params
      params.require(:question_list).permit(:name, :visibility)
    end
end
