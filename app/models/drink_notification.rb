class DrinkNotification < ApplicationRecord
  belongs_to :user
  belongs_to :group
  has_many :drink_requests

  validates :limit, presence: true
  validates :limit, numericality: { only_integer: true, greater_than: 0 }

  enum status: [ :boiling, :brewing, :ready ]
end
