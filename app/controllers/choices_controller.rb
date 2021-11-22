class ChoicesController < ApplicationController
  before_action :authenticate_admin!, only: [:create, :update, :destroy]
  before_action :set_choice, only: [:show, :update, :destroy]

  # GET /questions/1/choices
  def index
    @choices = Question.find(params[:question_id]).choices

    render json: @choices
  end

  # GET /choices/1
  def show
    render json: @choice
  end

  # POST /chapters/1/choices
  def create
    @choice = Choice.new(choice_params)
    @choice.question = Question.find(params[:question_id])

    if @choice.save
      render json: @choice, status: :created, location: @choice
    else
      render json: @choice.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /choices/1
  def update
    if @choice.update(choice_params)
      render json: @choice
    else
      render json: @choice.errors, status: :unprocessable_entity
    end
  end

  # DELETE /choices/1
  def destroy
    @choice.destroy
  end

  # GET /choices/1/stats
  def stats
    @choice = Choice.find(params[:choice_id])
    render json: { record_count: @choice.records.count }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_choice
      @choice = Choice.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def choice_params
      params.require(:choice).permit(:content, :is_answer, :question_id)
    end
end
