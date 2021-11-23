class QuestionListsController < ApplicationController
  before_action :set_question_list, only: [:show, :destroy, :show_questions]
  before_action :authenticate_user!, except: [:show, :show_questions]

  # GET /question_lists
  def index
    render json: current_user.question_lists
  end

  # GET /question_lists/1
  def show
    if @question_list.visiblity == "public" || @question_list.owner == current_user
      render json: @question_list
    else
      render json: {}, status: :forbidden
    end
  end

  # POST /question_lists
  def create
    @question_list = QuestionList.new(question_list_params)
    @question_list.owner = current_user

    if @question_list.save
      render json: @question_list, status: :created, location: @question_list
    else
      render json: @question_list.errors, status: :unprocessable_entity
    end
  end

  # DELETE /question_lists/1
  def destroy
    @question_list.destroy
  end

  # GET /question_lists/1/questions
  def show_questions
    if @question_list.visiblity == "public" || @question_list.owner == current_user
      render json: QuestionListItem.where(:question_list_id => @question_list.id)
    else
      render json: {}, status: :forbidden
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question_list
      @question_list = QuestionList.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def question_list_params
      params.require(:question_list).permit(:name, :visiblity, :forked_from_id)
    end
end
