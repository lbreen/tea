class Message < ApplicationRecord
  belongs_to :group
  belongs_to :user
  validates :content, presence: true

  paginates_per 10 # Kaminari gem config

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
      locals: { message: message, user_is_author: false }
    )
  end
end
