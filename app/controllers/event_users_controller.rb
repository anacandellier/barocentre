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
    if @event_user.save!
      redirect_to event_event_users_path(@event)
    else
      render :new, status: :unprocessable_entity
    end
    @event.open!
  end

  def barocentre
    @event = Event.find(params[:event_id])
    @eventusers = @event.event_users
    second_barycenter
    @markers = @eventusers.geocoded.map do |eventuser|
      {
        lat: eventuser.latitude,
        lng: eventuser.longitude,
        user_name: eventuser.user.email,
        info_window_html: render_to_string(partial: "info_window", locals: {event_user: eventuser} ),
        marker_html: render_to_string(partial: "marker")
      }
    end
    @barycenter_marker =[{
      lat: @event.barycenter_lat,
      lng: @event.barycenter_lng,
      marker_html: render_to_string(partial: "marker"),
      }]
  end

  private

  def event_user_params
    params.require(:event_user).permit(:user_address, :transport)
  end

  def first_barycenter
    @event = Event.find(params[:event_id])
    @eventusers = @event.event_users
    @addresses = []
    @eventusers.each do |eventuser|
      @addresses << eventuser.user_address
    end
    Geocoder::Calculations.geographic_center(@addresses)
  end

  def speed_calculation
    @event = Event.find(params[:event_id])
    @eventusers = @event.event_users
    bary_lat = first_barycenter.first
    bary_lng = first_barycenter.last
    @distance = []
    @eventusers.each do |eventuser|
      url = "https://maps.googleapis.com/maps/api/directions/json?origin=#{eventuser.latitude},#{eventuser.longitude}&destination=#{bary_lat},#{bary_lng}&mode=#{eventuser.transport}&arrival_time=#{@event.date.to_i}&key=#{ENV['GOOGLE_API_KEY']}"
      result = JSON.parse(URI.open(url).read)
      distance = result["routes"][0]["legs"][0]["distance"]["value"]
      duration = result["routes"][0]["legs"][0]["duration"]["value"]
      eventuser.update(distance: distance)
      eventuser.update(duration: duration)
      if duration != 0
        eventuser.update(speed: distance / duration.to_f)
      else
        eventuser.update(speed: 1)
      end
    end
  end

  def second_barycenter
    @event = Event.find(params[:event_id])
    @eventusers = @event.event_users
    speed_calculation
    sum_lat = 0
    sum_lng = 0
    sum_speed = 0
    @eventusers.each do |eventuser|
      sum_speed += eventuser.speed
      sum_lat += eventuser.latitude * eventuser.speed

      sum_lng += eventuser.longitude * eventuser.speed

    end
    if sum_speed != 0
      sec_bary_lat = sum_lat / sum_speed.to_f
      sec_bary_lng = sum_lng / sum_speed.to_f
    end
    @event.update(barycenter_lat: sec_bary_lat)
    @event.update(barycenter_lng: sec_bary_lng)
  end
end
