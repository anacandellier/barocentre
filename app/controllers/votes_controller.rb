class VotesController < ApplicationController

  def create
    @event = Event.find(params[:event_id])
    @user = @event.event_users.find_by(user: current_user)
    @previous_votes = Vote.where(event_user: @user)
    @previous_votes.destroy_all
    @vote = Vote.new
    @vote.event_user = @user
    @vote.bar = Bar.find(params[:bar])
    if @vote.save
      redirect_to event_classment_path(@event)
    else
      render "bars/index"
    end
  end
end
