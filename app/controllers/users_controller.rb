class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    params[:user_id]
  end
end
