class DrinkRequest < ApplicationRecord
  belongs_to :user
  belongs_to :drink_notification

  validates :drink_type, inclusion: { in: %w(Tea Coffee) }

  before_validation :user_has_more_than_one_request?

  private

  def user_has_more_than_one_request?
    self.drink_notification.drink_requests.each do |r|
      if r.user == self.user
        raise "You can't have more than one request per notification"
      end
    end
  end
end
