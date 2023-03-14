class Vote < ApplicationRecord
  belongs_to :event_user
  belongs_to :bar

  delegate :user, :to => :event_user, :allow_nil => true

end
