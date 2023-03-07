class EventUsersController < ApplicationController

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
