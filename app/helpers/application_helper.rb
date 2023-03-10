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
      return event_bars_path(event)
    end
  end

end
