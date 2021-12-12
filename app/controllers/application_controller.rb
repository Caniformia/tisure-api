class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
      devise_parameter_sanitizer.permit(:account_update, keys: [:nickname])
    end

    def record_stats(records)
      return {
        all_users: {
          record_count: records.count,
          correct_count: records.where(is_correct: true).count
        },
        current_user: current_user ? {
          record_count: records.where(user: current_user).count,
          correct_count: records.where(user: current_user, is_correct: true).count
        } : nil
      }
    end

    def authenticate_admin!
      authenticate_user!
      render json: {}, status: :forbidden if user_signed_in? and not current_user.is_admin?
    end
end
