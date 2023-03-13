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

  def map
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
    @barycenter_marker = [{
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
    set_event_users
    @addresses = []
    @eventusers.each do |eventuser|
      @addresses << eventuser.user_address
    end
    @first_barycenter = Geocoder::Calculations.geographic_center(@addresses)
  end

  # {"geocoded_waypoints"=>
  #   [{"geocoder_status"=>"OK", "place_id"=>"ChIJi1DaGFJt5kcRL5RFo8zcuWQ", "types"=>["establishment", "point_of_interest", "school"]},
  #    {"geocoder_status"=>"OK", "place_id"=>"ChIJi1DaGFJt5kcRL5RFo8zcuWQ", "types"=>["establishment", "point_of_interest", "school"]}],
  #  "routes"=>
  #   [{"bounds"=>{"northeast"=>{"lat"=>48.8632846, "lng"=>2.3765937}, "southwest"=>{"lat"=>48.8632846, "lng"=>2.3765937}},
  #     "copyrights"=>"Map data ©2023 Google",
  #     "legs"=>
  #      [{"distance"=>{"text"=>"1 m", "value"=>0},
  #        "duration"=>{"text"=>"1 min", "value"=>0},
  #        "end_address"=>"68 Ave Parmentier, 75011 Paris, France",
  #        "end_location"=>{"lat"=>48.8632846, "lng"=>2.3765937},
  #        "start_address"=>"68 Ave Parmentier, 75011 Paris, France",
  #        "start_location"=>{"lat"=>48.8632846, "lng"=>2.3765937},
  #        "steps"=>
  #         [{"distance"=>{"text"=>"1 m", "value"=>0},
  #           "duration"=>{"text"=>"1 min", "value"=>0},
  #           "end_location"=>{"lat"=>48.8632846, "lng"=>2.3765937},
  #           "html_instructions"=>"Head on <b>Rue Lechevin</b>",
  #           "polyline"=>{"points"=>"orfiHudoM"},
  #           "start_location"=>{"lat"=>48.8632846, "lng"=>2.3765937},
  #           "travel_mode"=>"WALKING"}],
  #        "traffic_speed_entry"=>[],
  #        "via_waypoint"=>[]}],
  #     "overview_polyline"=>{"points"=>"orfiHudoM"},
  #     "summary"=>"Rue Lechevin",
  #     "warnings"=>["Walking directions are in beta. Use caution – This route may be missing sidewalks or pedestrian paths."],
  #     "waypoint_order"=>[]}],
  #  "status"=>"OK"}
  def speed_calculation
    first_barycenter
    bary_lat = @first_barycenter.first
    bary_lng = @first_barycenter.last
    # @distance = []
    @eventusers.each do |eventuser|
      url = "https://maps.googleapis.com/maps/api/directions/json?origin=#{eventuser.latitude},#{eventuser.longitude}&destination=#{bary_lat},#{bary_lng}&mode=#{eventuser.transport}&arrival_time=#{@event.date.to_i}&key=#{ENV['GOOGLE_API_KEY']}"
      result = JSON.parse(URI.open(url).read)
      unless result.dig('available_travel_modes')&.map(&:downcase)&.include?(eventuser.transport)
        url = "https://maps.googleapis.com/maps/api/directions/json?origin=#{eventuser.latitude},#{eventuser.longitude}&destination=#{bary_lat},#{bary_lng}&mode=walking&arrival_time=#{@event.date.to_i}&key=#{ENV['GOOGLE_API_KEY']}"
        result = JSON.parse(URI.open(url).read)
      end
      distance = result.dig('routes')&.first&.dig('legs')&.first&.dig('distance', 'value')
      duration = result.dig('routes')&.first&.dig('legs')&.first&.dig('duration', 'value')
      eventuser.update(distance: distance, duration: duration)
      if duration.zero?
        eventuser.update(speed: 1)
      else
        eventuser.update(speed: distance.fdiv(duration))
      end
    end
  end

  def second_barycenter
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
    # Appeler le calcul du barycentre uniquement à la fin (ou quand un nouvel invité arrive), et on supprime donc la liste des bars
    @event.bars.destroy_all
  end

  def set_event_users
    @event = Event.find(params[:event_id])
    @eventusers = @event.event_users
  end
end
