class EventsController < ApplicationController

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.user = current_user
    if @event.save
      redirect_to event_path(@event)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def invite
    @event = Event.find(params[:id])
  end


  def show
    @event = Event.find(params[:id])
  end

  def share
    @event = Event.find(params[:id])
  end


  private

  def event_params
    params.require(:event).permit(:name, :date)
  end

end
