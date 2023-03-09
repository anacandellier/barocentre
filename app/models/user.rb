class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :events
  has_many :event_users
  has_many :events_as_participant, through: :event_users, source: :event
  has_one_attached :photo
  validates :username, presence: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def participates_to_event?(event)
    EventUser.where(event: event, user: self).any?
  end
end
