class EventUser < ApplicationRecord
  belongs_to :event
  belongs_to :user
  has_many :votes, dependent: :destroy
  validates :user_address, presence: true
  validates_uniqueness_of :user_id, scope: [:event_id]
  validates :transport, presence: true, inclusion: { in: %w[driving transit bicycling] }

  geocoded_by :user_address
  after_validation :geocode, unless: :lon_lat_changed?

  def transport_icon
    {
      'bicycling' => '<i class="fa-solid fa-person-biking"></i>',
      'transit' => '<i class="fa-solid fa-train-subway"></i>',
      'driving' => '<i class="fa-solid fa-car"></i>'
    }[transport].html_safe
  end

  private

  def lon_lat_changed?
    longitude_changed? && latitude_changed?
  end
end
