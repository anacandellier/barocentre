class EventUser < ApplicationRecord
  belongs_to :mean_of_transport
  belongs_to :event
  belongs_to :user
end
