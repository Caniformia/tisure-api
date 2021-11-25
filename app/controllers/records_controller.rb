class RecordsController < ApplicationController
  before_action :authenticate_user!, except: [:stats]
  before_action :set_record, only: [:show, :destroy]

  wrap_parameters include: [*Record.attribute_names, :choice_ids]

  # GET /records/1
  def show
      render json: @record, include: ['*', 'question.choices']
  end

  # POST /records
  def create
    @record = Record.new(record_params)
    @record.user = current_user

    if @record.save
      render json: @record, status: :created, location: @record
    else
      render json: @record.errors, status: :unprocessable_entity
    end
  end

  # DELETE /records/1
  def destroy
    @record.destroy
  end

  # GET /stats
  def stats
    render json: record_stats(Record.all)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_record
      @record = Record.find(params[:id])
      if @record.user != current_user
        render json: {}, status: :forbidden
      end
    end

    # Only allow a list of trusted parameters through.
    def record_params
      params.require(:record).permit(:question_id, :is_correct, :choice_ids => [])
    end
end
