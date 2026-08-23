class ApplicationController < ActionController::Base
  include Pundit::Authorization

  before_action :authenticate_user!

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  after_action :verify_authorized, unless: :skip_pundit_authorization_verification?
  after_action :verify_policy_scoped, if: :verify_policy_scope?

  private

  def user_not_authorized
    redirect_back(
      fallback_location: root_path,
      alert: "You are not authorized to perform this action."
    )
  end

  def verify_policy_scope?
    action_name == "index" && !devise_controller?
  end

  def skip_pundit_authorization_verification?
    devise_controller? || action_name == "index"
  end 
  
end