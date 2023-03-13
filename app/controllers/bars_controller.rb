require "uri"
require "net/http"

class BarsController < ApplicationController
  def index
    @event = Event.find(params[:event_id])
    @event.vote!
    @bars = Bar.where(event_id: params[:event_id])
    @markers = @bars.map do |bar|
      {
        lat: bar.latitude,
        lng: bar.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: {bar: bar}),
        marker_html: render_to_string(partial: "marker", locals: {bar: bar})
      }
     end
  end

  def map
    @event = Event.find(params[:event_id])
    @bars = Bar.where(event_id: params[:event_id])
    @markers = @bars.map do |bar|
      {
        lat: bar.latitude,
        lng: bar.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: {bar: bar}),
          marker_html: render_to_string(partial: "marker", locals: {bar: bar})
      }
    end
    @barycenter_marker = [{
      lat: @event.barycenter_lat,
      lng: @event.barycenter_lng,
      marker_html: render_to_string(partial: "marker")
    }]
  end

  def create
    @event = Event.find(params[:event_id])
    @bar = Bar.new(bar_params)
    @bar.event = @event
    if @bar.save
      redirect_to event_bars_path(@event)
    else
      render :index
    end
  end

  def new
    @event = Event.find(params[:event_id])
    @bar = Bar.new
  end

  def classment
    @event = Event.find(params[:event_id])
    @event_users = Event.find(params[:event_id]).event_users
    @bars = Bar.where(event_id: params[:event_id]).sort { |a, b| b.votes.count <=> a.votes.count }
  end

  private

  def bar_params
    params.require(:bar).permit(:name, :address, :rating, :place_id)
  end

end
