class TagsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :set_tag, only: [:destroy]

  # GET /questions/1/tags
  def index
    @tags = Question.find(params[:question_id]).tags

    render json: {
      all_users: @tags.group(:name).order(count_all: :desc).count,
      current_user: current_user ? @tags.where(user: current_user).select(:id, :name) : nil
    }
  end

  # GET /tags/foo
  def show
    render json: Question.joins(:tags).where('tags.name' => params[:name]).distinct
  end

  # POST /questions/1/tags
  def create
    @tag = Tag.new(tag_params)
    @tag.question = Question.find(params[:question_id])
    @tag.user = current_user

    if @tag.save
      render json: @tag, status: :created, location: @tag
    else
      render json: @tag.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tags/1
  def destroy
    if @tag.user != current_user and not current_user.is_admin?
      render json: {}, status: :forbidden
    else
      @tag.destroy
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tag
      @tag = Tag.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tag_params
      params.require(:tag).permit(:name, :question_id)
    end
end
