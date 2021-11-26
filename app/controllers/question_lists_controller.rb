require 'securerandom'

class QuestionListsController < ApplicationController
  before_action :authenticate_user!, except: [:show_share]
  before_action :set_question_list, only: [:show, :update, :destroy, :reset_link]

  # GET /question_lists
  def index
    render json: current_user.question_lists, include: []
  end

  # GET /question_lists/1
  def show
    render json: @question_list
  end

  # GET /question_lists/share/foobar
  def show_share
    render json: QuestionList.where(share_link: params[:link], visibility: :shared).first
  end

  # POST /question_lists
  def create
    @question_list = QuestionList.new(question_list_params)
    @question_list.owner = current_user
    @question_list.share_link = new_share_link

    if params[:forked_from_link]
      forked_from = QuestionList.where(share_link: params[:forked_from_link], visibility: :shared).first
      unless forked_from
        render json: {}, status: :not_found
        return
      end
      forked_from.question_list_items.each do |rec|
        @question_list.questions << rec.question
      end
      unless forked_from.owner == current_user
        @question_list.forked_from = forked_from
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
    if params[:visibility] != 'shared' and QuestionList.where(forked_from: @question_list)
      render json: {}, status: :unprocessable_entity
    elsif @question_list.update(question_list_params)
      render json: @question_list
    else
      render json: @question_list.errors, status: :unprocessable_entity
    end
  end

  # DELETE /question_lists/1
  def destroy
    @question_list.destroy
  end

  # GET /question_lists/1/reset_link
  def reset_link
    if @question_list.update(share_link: new_share_link)
      render json: @question_list
    else
      render json: @question_list.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question_list
      @question_list = QuestionList.find(params[:id])
      unless @question_list.owner == current_user || current_user.is_admin?
        render json: {}, status: :forbidden
      end
    end

    # Only allow a list of trusted parameters through.
    def question_list_params
      params.require(:question_list).permit(:name, :visibility)
    end

    def new_share_link
      SecureRandom.alphanumeric(6)
    end
end
