class Drink < ApplicationRecord
  validates :type, inclusion: { in: ["tea", "coffee"] }
end
