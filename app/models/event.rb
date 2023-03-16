class Event < ApplicationRecord
  belongs_to :user
  has_many :event_users, dependent: :destroy
  has_many :bars
  belongs_to :selected_bar, class_name: :Bar, foreign_key: :bar_id, optional: true
  validates :name, presence: true
  validates :date, presence: true

  enum status: {
    created: 0,
    open: 1,
    vote: 2,
    closed: 3
  }

  scope :ongoing, -> { where(status: [:open, :vote]) }
  scope :past, -> { where('date < :today', today: DateTime.now) }
  scope :future, -> { where('date > :today', today: DateTime.now) }
  scope :for_user, -> (user) {
    joins("LEFT JOIN event_users ON event_users.event_id = events.id")
    .where("events.user_id = ? OR event_users.user_id = ?", user.id, user.id)
    .distinct
  }

  def most_voted_bars
    bars.group_by do |bar|
      bar.votes.count
    end.to_a.sort_by(&:first).last.last
  end

end
