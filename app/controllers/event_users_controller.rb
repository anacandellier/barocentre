require "json"
require "open-uri"

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
        marker_html: render_to_string(partial: "marker", locals: {event_user: eventuser})
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
    if @event_user.save!
      EventChannel.broadcast_to(@event, {event_user: render_to_string(partial: "event_user", locals: { element: @event_user })})
      redirect_to event_event_users_path(@event)
    else
      render :new, status: :unprocessable_entity
    end
    @event.open!
  end

  def destroy
    @event_user = EventUser.find(params[:id])
    @event = @event_user.event
    @event_user.destroy
    redirect_to event_event_users_path(@event), status: :see_other
  end

  def map
    @event = Event.find(params[:event_id])
    @eventusers = @event.event_users
    @markers = @eventusers.geocoded.map do |eventuser|
      {
        lat: eventuser.latitude,
        lng: eventuser.longitude,
        user_name: eventuser.user.email,
        info_window_html: render_to_string(partial: "info_window", locals: {event_user: eventuser} ),
        marker_html: render_to_string(partial: "marker", locals: {event_user: eventuser} )
      }
    end
  end

  private

  def event_user_params
    params.require(:event_user).permit(:user_address, :transport, :latitude, :longitude)
  end
end
