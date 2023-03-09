module ApplicationHelper
  def path_to_event(event)
    my_participation = event.event_users.find_by(user: current_user)
    if my_participation.nil?
      return new_event_event_user_path(event)
    else
      return event_path(event)
    end
  end
end
