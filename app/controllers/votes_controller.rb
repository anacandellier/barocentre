class VotesController < ApplicationController

  def create
    @event = Event.find(params[:event_id])
    @bar = Bar.find(params[:bar])
    @bars = @event.bars
    @user = @event.event_users.find_by(user: current_user)
    @previous_votes = Vote.where(event_user: @user)
    @previous_votes.destroy_all
    @vote = Vote.new
    @vote.event_user = @user
    @vote.bar = @bar
    if @vote.save
      EventChannel.broadcast_to(@event, {
        bar_card: render_to_string(partial: "bars/bar_classment", locals: { bar: @bar, event: @event }),
        bar_id: @bar.id,
        most_voted_bars_ids: @event.most_voted_bars.map(&:id)
      })
      redirect_to event_classment_path(@event)
    else
      flash.now[:alert] = 'Vous ne participez pas à l\'évènement'
      render "bars/index", status: :unprocessable_entity
    end
  end
end
