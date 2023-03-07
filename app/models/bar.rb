class Bar < ApplicationRecord
  has_many :votes
  validates :name, presence: true
  validates :address, presence: true
end
