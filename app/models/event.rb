class Event < ApplicationRecord
  belongs_to :user
  has_many :event_users
  validates :name, presence: true
  validates :date, presence: true
  enum status: {
    open: 0,
    vote: 1,
    closed: 2
  }
  scope :ongoing, -> { where(status: [:open, :vote]) }
  scope :past, -> { where('date < :today', today: DateTime.now) }
  scope :future, -> { where('date > :today', today: DateTime.now) }
  scope :for_user, -> (user) {
    joins("LEFT JOIN event_users ON event_users.event_id = events.id")
    .where("events.user_id = ? OR event_users.user_id = ?", user.id, user.id)
    .distinct
  }
end
