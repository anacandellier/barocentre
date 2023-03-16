module ApplicationHelper

  def path_to_event(event)
    my_participation = event.event_users.find_by(user: current_user)
    if my_participation.nil?
      return new_event_event_user_path(event)
    else
      dashboard_to_event(event)
    end
  end

  def dashboard_to_event(event)
    if event.created?
      return event_event_users_path(event)
    elsif event.open?
      return event_event_users_path(event)
    elsif event.vote?
      if EventUser.find_by(user: current_user, event: event).votes.present?
        return event_classment_path(event)
      else
        return bars_path(event)
      end
    elsif event.closed?
      return event_itineraire_path(event)
    end
  end
end
