class ChapterProgressesController < ApplicationController
  before_action :authenticate_user!, only: [:show, :update]
  before_action :set_chapter_progress, only: [:show, :update]

  # GET /chapter_progresses/1
  def show
    render json: @chapter_progress
  end

  # PATCH/PUT /chapter_progresses/1
  def update
    if @chapter_progress.update(chapter_progress_params)
      render json: @chapter_progress
    else
      render json: @chapter_progress.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chapter_progress
      @chapter_progress = ChapterProgress.find_or_create_by(user: current_user, chapter_id: params[:chapter_id])
    end

    # Only allow a list of trusted parameters through.
    def chapter_progress_params
      params.require(:chapter_progress).permit(:last_accessed_question_id)
    end
end
