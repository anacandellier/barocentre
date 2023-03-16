class Bar < ApplicationRecord
  has_many :votes, dependent: :destroy
  validates :name, uniqueness: { scope: :event_id }
  validates :address, presence: true
  belongs_to :event

  def most_voted?
    event.most_voted_bars.include?(self)
  end
end
