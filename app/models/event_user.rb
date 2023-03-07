class EventUser < ApplicationRecord
  belongs_to :mean_of_transport
  belongs_to :event
  belongs_to :user
  validates :user_address, presence: true
  validates :user_lat, presence: true
  validates :user_long, presence: true
end
