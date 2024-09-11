class ApplicationController < ActionController::Base
  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  before_action :authenticate_user!

  private

  def user_not_authorized
    
    flash[:alert] = "You are not authorized to perform this action."
    Rails.logger.error { "User not authorized: Redirecting to login." }  # Log en cas d'échec d'autorisation
    redirect_to new_user_session_path
  end
end
