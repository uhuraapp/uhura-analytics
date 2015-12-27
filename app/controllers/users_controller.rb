class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  before_action :authenticate_admin!

  def index
    @users = User.all
  end

  def show
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params[:user]
    end
end
