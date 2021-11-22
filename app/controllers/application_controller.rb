class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken

  protected
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
end
