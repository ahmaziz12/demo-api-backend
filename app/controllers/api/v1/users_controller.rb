class Api::V1::UsersController < ApplicationController
  before_action :set_user, except: :index

  def index
    users = User.all
    render json: users, meta: { count: users.count },
           adapter: :json, each_serializer: Api::V1::UserSerializer
  end

  def show
    render json: @user
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
