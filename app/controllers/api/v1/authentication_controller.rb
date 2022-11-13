class Api::V1::AuthenticationController < ApplicationController
  skip_before_action :authorize_request

  def login
    @user = User.find_by_email(params[:email])
    if @user&.valid_password?(params[:password])
      token = JsonWebToken.encode(user_id: @user.id)
      time = Time.now + 24.hours.to_i
      render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"),
                     email: @user.email }, status: :ok
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end

  def signup
    @user = User.new(signup_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  private

  def login_params
    params.permit(:email, :password)
  end

  def signup_params
    params.permit(
      :first_name, :last_name, :email, :password, :password_confirmation
    )
  end
end
