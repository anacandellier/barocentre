class EventUsersController < ApplicationController
  def index
    @event = Event.find(params[:event_id])
    @eventusers = @event.event_users

    @markers = @eventusers.geocoded.map do |eventuser|
      {
        lat: eventuser.latitude,
        lng: eventuser.longitude,
        user_name: eventuser.user.email,
        info_window_html: render_to_string(partial: "info_window", locals: {event_user: eventuser} ),
        marker_html: render_to_string(partial: "marker")
      }
    end
  end

  def new
    @event_user = EventUser.new
    @event = Event.find(params[:event_id])
  end

  def create
    @event = Event.find(params[:event_id])
    @event_user = EventUser.new(event_user_params)
    @event_user.user = current_user
    @event_user.event = @event
    if @event_user.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def event_user_params
    params.require(:event_user).permit(:user_address, :mean_of_transport_id)
  end
end
