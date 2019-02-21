class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def home
  end

  private

    # Before filters

    # Confirms a logged-in user.
    def logged_in_user
      if logged_in? == false
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
    end
  end
end
