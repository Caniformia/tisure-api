class RecordsController < ApplicationController
  before_action :authenticate_user!, except: [:stats]

  wrap_parameters include: [*Record.attribute_names, :choice_ids]

  # POST /records
  def create
    @record = Record.new(record_params)
    @record.user = current_user

    if @record.save
      render json: @record, status: :created
    else
      render json: @record.errors, status: :unprocessable_entity
    end
  end

  # DELETE /records
  def clear
    current_user.records.destroy_all
  end

  # GET /records/stats
  def stats
    render json: record_stats(Record.all)
  end

  # GET /records/mistakes
  def mistakes
    last_records = current_user.records.group(:question_id).select('*, MAX(created_at)')
    render json: Record.from(last_records, :records).where(is_correct: false)
  end

  private
    # Only allow a list of trusted parameters through.
    def record_params
      params.require(:record).permit(:question_id, :is_correct, :choice_ids => [])
    end
end
