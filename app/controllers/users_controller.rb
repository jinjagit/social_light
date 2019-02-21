class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show]

  def index
    @users = User.all
  end

  def show
    @user = current_user
    @events = @user.events
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:info] = "Account creation successful!"
      redirect_to @user
    else
      render 'new'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name)
    end
end
