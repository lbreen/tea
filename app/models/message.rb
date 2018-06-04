class Message < ApplicationRecord
  belongs_to :group
  belongs_to :user
  validates :content, presence: true

  paginates_per 10

  after_create_commit {broadcast_message}

  def broadcast_message
    MessageBroadcastJob.perform_now({
      message: self,
      new_date: message_on_new_date?(self)
    })
  end

  private

  def message_on_new_date?(message)
    if message.group.messages[-2].nil?
      # Message is the first in the group
      return true
    elsif Date.today == message.group.messages[-2].created_at.to_date
      # Previous message from today
      return false
    else
      # First message of the day
      return true
    end
  end
end
