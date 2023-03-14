class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home

  end

  def dashboard
    # @my_ongoing_events = current_user.events.ongoing # ceux dont je suis admin et qui sont en statut open ou vote
    # @future_events = current_user.events_as_participant.future # ceux dont je suis paticipant et qui sont a venir
    # @past_events = current_user.events_as_participant.past # ceux dont je suis participant et qui sont passés
    @my_future_events = Event.for_user(current_user).future.order(date: :asc)  # ceux dont je suis participant ou admin et qui sont open ou vote
    @my_past_events = Event.for_user(current_user).past.order(date: :asc) # ceux dont je suis participant ou admin et qui sont open ou vote
  end
end
