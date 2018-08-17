class DrinkRequest < ApplicationRecord
  belongs_to :user
  belongs_to :drink_notification

  validates :drink_type, inclusion: { in: %w(Tea Coffee) }

  before_validation :user_has_more_than_one_request?
  before_validation :request_exceed_notification_limit?

  private

  def user_has_more_than_one_request?
    self.drink_notification.drink_requests.each do |r|
      if r.user == self.user
        message = "You can't have more than one request per notification"
        self.errors.add(:base, message: message)
      end
    end
  end

  def request_exceed_notification_limit?
    if self.drink_notification.drink_requests.count == self.drink_notification.limit
      self.errors.add(:base, message: 'Sorry! Looks like this round is full!')
    end
  end
end
