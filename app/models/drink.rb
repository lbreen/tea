class Drink < ApplicationRecord
  belongs_to :user
  belongs_to :group

  validates :limit, presence: true
  validates :limit, numericality: { only_integer: true, greater_than: 0 }

  enum status: %i[boiling ready]
end
