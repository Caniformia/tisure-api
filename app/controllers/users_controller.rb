class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show_current]

  def show
    render json: User.find(params[:id])
  end

  def show_current
    render json: current_user
  end

  def question_lists
    user = User.find(params[:user_id])
    if user == current_user or current_user&.is_admin?
      render json: user.question_lists
    else
      render json: user.question_lists.where(visibility: :public)
    end
  end
end