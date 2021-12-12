class ProgressesController < ApplicationController
  before_action :authenticate_user!, only: [:show, :update]
  before_action :set_progress, only: [:show, :update]

  # GET /subjects/1/progress
  def show
    render json: @progress
  end

  # PATCH/PUT /subjects/1/progress
  def update
    if @progress.update(progress_params)
      render json: @progress
    else
      render json: @progress.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_progress
      @progress = Progress.find_or_create_by(user: current_user, subject_id: params[:subject_id])
    end

    # Only allow a list of trusted parameters through.
    def progress_params
      params.require(:progress).permit(:last_accessed_question_id)
    end
end
