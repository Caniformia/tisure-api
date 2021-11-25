class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show_current]

  def show
    render json: User.find(params[:id])
  end

  def show_current
    render json: current_user
  end
end
