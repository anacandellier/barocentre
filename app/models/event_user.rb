class EventUser < ApplicationRecord
  belongs_to :mean_of_transport
  belongs_to :event
  belongs_to :user
  validates :user_address, presence: true
  validates_uniqueness_of :user_id, :scope => [:event_id]

  geocoded_by :user_address
  after_validation :geocode, if: :will_save_change_to_user_address?
end
