class Bar < ApplicationRecord
  has_many :votes, dependent: :destroy
  validates :name, uniqueness: { scope: :event_id }
  validates :address, presence: true
end
