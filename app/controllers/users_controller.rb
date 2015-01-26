class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @users = User.all
  end

  def show
    @user = current_user
    @services = @user.services
  end

  def edit
    @user = current_user
  end

  def destroy
    @user = current_user
  end

end
