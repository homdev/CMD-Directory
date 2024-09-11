class Admin::DashboardController < ApplicationController
  layout 'admin'
  before_action :authenticate_user!
  before_action :authorize_admin

  def index
    @users = User.all
    @total_users = User.count
    @users_by_role = User.group(:role).count
    logger.debug { "Total users: #{@total_users}, Users by role: #{@users_by_role.inspect}" }
    Rails.logger.debug { "Trying to authorize [:admin, User] with policy: #{Pundit.policy!(current_user, [:admin, User]).class.name}" }
    authorize [:admin, User]
  end

  private

  def authorize_admin
    redirect_to(root_path, alert: "Accès refusé") unless current_user.admin?
  end
end
