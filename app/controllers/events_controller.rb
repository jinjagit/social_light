class EventsController < ApplicationController
  before_action :logged_in, only: [:new]

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(creator_id: session[:user_id], title: event_params[:title],
                       info: event_params[:info], location: event_params[:location],
                       date: event_params[:date])
     if @event.save
       flash[:info] = "Event created!"
       redirect_to user_path(current_user)
     else
       render 'new'
     end
  end

  private

    def event_params
      params.require(:event).permit(:title, :info, :location, :date)
    end

    def logged_in
      if logged_in? == false
        flash[:danger] = "Please log in."
        redirect_to(login_path)
      end
    end
end
