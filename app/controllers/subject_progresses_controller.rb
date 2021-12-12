class SubjectProgressesController < ApplicationController
  before_action :authenticate_user!, only: [:show, :update]
  before_action :set_subject_progress, only: [:show, :update]

  # GET /subjects/1/progress
  def show
    render json: @subject_progress
  end

  # PATCH/PUT /subjects/1/subject_progress
  def update
    if @subject_progress.update(subject_progress_params)
      render json: @subject_progress
    else
      render json: @subject_progress.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subject_progress
      @subject_progress = SubjectProgress.find_or_create_by(user: current_user, subject_id: params[:subject_id])
    end

    # Only allow a list of trusted parameters through.
    def subject_progress_params
      params.require(:subject_progress).permit(:last_accessed_chapter_id)
    end
end
