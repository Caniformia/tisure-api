class QuestionListsController < ApplicationController
  before_action :set_question_list, only: [:show, :update, :destroy]

  # GET /question_lists
  def index
    @question_lists = QuestionList.all

    render json: @question_lists
  end

  # GET /question_lists/1
  def show
    render json: @question_list
  end

  # POST /question_lists
  def create
    @question_list = QuestionList.new(question_list_params)

    if @question_list.save
      render json: @question_list, status: :created, location: @question_list
    else
      render json: @question_list.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /question_lists/1
  def update
    if @question_list.update(question_list_params)
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
    # Use callbacks to share common setup or constraints between actions.
    def set_question_list
      @question_list = QuestionList.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def question_list_params
      params.require(:question_list).permit(:name, :owner_id, :visiblity, :forked_from_id)
    end
end
