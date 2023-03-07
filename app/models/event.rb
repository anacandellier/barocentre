class Event < ApplicationRecord
  belongs_to :user
  has_many :event_users
  validates :name, presence: true
  validates :time, presence: true
end
