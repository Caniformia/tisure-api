class ChaptersController < ApplicationController
  before_action :authenticate_admin!, only: [:create, :update, :destroy]
  before_action :set_chapter, only: [:show, :update, :destroy]

  # GET /subjects/1/chapters
  def index
    @chapters = Subject.find(params[:subject_id]).chapters

    render json: @chapters
  end

  # GET /chapters/1
  def show
    render json: @chapter
  end

  # POST /subjects/1/chapters
  def create
    @chapter = Chapter.new(chapter_params)
    @chapter.subject = Subject.find(params[:subject_id])

    if @chapter.save
      render json: @chapter, status: :created, location: @chapter
    else
      render json: @chapter.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /chapters/1
  def update
    if @chapter.update(chapter_params)
      render json: @chapter
    else
      render json: @chapter.errors, status: :unprocessable_entity
    end
  end

  # DELETE /chapters/1
  def destroy
    @chapter.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chapter
      @chapter = Chapter.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def chapter_params
      params.require(:chapter).permit(:name, :subject_id)
    end
end
