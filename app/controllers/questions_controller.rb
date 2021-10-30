class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :update, :destroy]

  # GET /chapters/1/questions
  def index
    @questions = Chapter.find(params[:chapter_id]).questions

    render json: @questions
  end

  # GET /questions/1
  def show
    render json: @question
  end

  # POST /chapters/1/questions
  def create
    @question = Question.new(question_params)
    @question.chapter = Chapter.find(params[:chapter_id])

    if @question.save
      render json: @question, status: :created, location: @question
    else
      render json: @question.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /questions/1
  def update
    if @question.update(question_params)
      render json: @question
    else
      render json: @question.errors, status: :unprocessable_entity
    end
  end

  # DELETE /questions/1
  def destroy
    @question.destroy
  end

  # POST /questions/1/attach_image
  def attach_image
    @question = Question.find(params[:question_id])
    filename = "q#{@question.id}#{Rack::Mime::MIME_TYPES.invert[request.content_type]}"

    @question.image.attach(io: request.body, filename: filename, content_type: request.content_type)
    render json: @question
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def question_params
      params.require(:question).permit(:content, :is_multi_answer, :chapter_id)
    end
end
