class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    ActionCable.server.broadcast(
      "group_#{message.group.id}",
      message_partial: render_message(message),
      current_user_id: message.user.id
    )
  end

  private

  def render_message(message)
    ApplicationController.renderer.render(
      partial: 'messages/message',
      locals: { message: message, user_is_author: false }
    )
  end
end
