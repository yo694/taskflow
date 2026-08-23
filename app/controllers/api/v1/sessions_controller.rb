class Api::V1::SessionsController < ActionController::API
  def create
    user = User.find_by(email: params[:email])

    if user&.valid_password?(params[:password])
      token = JsonWebToken.encode(user_id: user.id)

      render json: { token: token }, status: :created
    else
      render json: { error: "invalid credentials" }, status: :unauthorized
    end
  end
end