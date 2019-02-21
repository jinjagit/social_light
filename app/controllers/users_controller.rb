class UsersController < ApplicationController
  before_action :logged_in_user, :correct_user, only: [:show]

  def index
    @users = User.all
  end

  def show
    @user = current_user
    @future_events = @user.events.future.order(date: :desc)
    @past_events = @user.events.past.order(date: :desc)
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

    # Confirms the correct user.
    def correct_user
      if logged_in?
        @user = User.find(params[:id])
        redirect_to(user_path(current_user)) unless current_user == @user
      end
    end
end
