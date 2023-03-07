class EventUsersController < ApplicationController
  def index
    @eventusers = EventUser.all

    @markers = @eventusers.geocoded.map do |eventuser|
      {lat: eventuser.latitude,
      lng: eventuser.longitude
      }
    end
  end
end
