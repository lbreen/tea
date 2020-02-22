class DrinkResponse < ApplicationRecord
  belongs_to :user
  belongs_to :drink

  validates :drink_type, presence: true, inclusion: { in: %w[Tea Coffee] }

  private

  def collect
    update(collected: true)
  end
end
