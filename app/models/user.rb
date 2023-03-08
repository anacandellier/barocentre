class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :events
  has_many :event_users
  has_many :events_as_participant, through: :event_users, source: :event
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

end
