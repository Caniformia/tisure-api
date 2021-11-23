class QuestionListItemsController < ApplicationController
  before_action :set_question_list_item, only: [:show, :create, :destroy]
  before_action :authenticate_user!

  # GET /question_list_items/1
  def show
    render json: @question_list_item
  end

  # POST /question_list_items
  def create
    @question_list_item = QuestionListItem.new(question_list_item_params)

    if @question_list_item.save
      render json: @question_list_item, status: :created, location: @question_list_item
    else
      render json: @question_list_item.errors, status: :unprocessable_entity
    end
  end

  # DELETE /question_list_items/1
  def destroy
    @question_list_item.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question_list_item
      @question_list_item = QuestionListItem.find(params[:id])
      @question_list = QuestionList.find(params[:question_list_id])

      unless @question_list.owner == current_user
        render json: {}, status: :forbidden
      end
    end

    # Only allow a list of trusted parameters through.
    def question_list_item_params
      params.require(:question_list_item).permit(:question_id, :question_list_id)
    end
end
