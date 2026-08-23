class Api::V1::BaseController < ActionController::API
  include Pundit::Authorization
  before_action :authenticate_request

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  attr_reader :current_user

  private

  def authenticate_request
    header = request.headers["Authorization"]
    token = header.split(" ").last if header&.start_with?("Bearer ")

    raise JWT::DecodeError, "Missing token" unless token

    decoded = JsonWebToken.decode(token)
    @current_user = User.find(decoded["user_id"])
  rescue JWT::ExpiredSignature
    render json: { error: "token expired" }, status: :unauthorized
  rescue JWT::DecodeError
    render json: { error: "invalid token" }, status: :unauthorized
  end

  def user_not_authorized
    render json: { error: "not authorized" }, status: :forbidden
  end
end