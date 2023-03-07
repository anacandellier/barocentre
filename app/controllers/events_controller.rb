class EventsController < ApplicationController

  def new
    @event = Event.new
  end

  def invite
    @event = Event.find(params[:id])
  end
end
