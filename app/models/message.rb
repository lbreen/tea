class Message < ApplicationRecord
  belongs_to :group
  belongs_to :user
  validates :content, presence: true

  paginates_per 10

  after_create :broadcast_message

  def broadcast_message
    ActionCable.server.broadcast("group_#{group.id}", {
      message_partial: render_message(self),
      current_user_id: user.id
    })
  end

  def render_message(message)
    message = ApplicationController.renderer.render(
      partial: 'messages/message',
      locals: { message: message, current_user: message.user }
    )
  end
  # after_create_commit {broadcast_message}

  # def broadcast_message
  #   MessageBroadcastJob.perform_now({
  #     message: self,
  #     new_date: message_on_new_date?(self)
  #   })
  # end

  # private

  # def message_on_new_date?(message)
  #   if message.group.messages[-2].nil?
  #     # Message is the first in the group
  #     return true
  #   elsif Date.today == message.group.messages[-2].created_at.to_date
  #     # Previous message from today
  #     return false
  #   else
  #     # First message of the day
  #     return true
  #   end
  # end
end
