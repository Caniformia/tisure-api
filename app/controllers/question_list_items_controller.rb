class QuestionListItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_question_list_item, only: [:destroy]
  before_action :authenticate_list_modify, only: [:create, :destroy]

  # POST /question_list_items
  def create
    @question_list_item = QuestionListItem.new(question_list_item_params)

    if @question_list_item.save
      render json: @question_list_item, status: :created
    else
      render json: @question_list_item.errors, status: :unprocessable_entity
    end
  end

  # DELETE /question_list_items/1
  def destroy
    @question_list_item.destroy
  end

  private
    def authenticate_list_modify
      @question_list = @question_list_item&.question_list || QuestionList.find(params[:question_list_id])
      unless @question_list.owner == current_user || current_user.is_admin?
        render json: {}, status: :forbidden
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_question_list_item
      @question_list_item = QuestionListItem.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def question_list_item_params
      params.require(:question_list_item).permit(:question_id, :question_list_id)
    end
end
