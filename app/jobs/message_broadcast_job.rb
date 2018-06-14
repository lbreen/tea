class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(payload)
    ActionCable.server.broadcast(
      "group-#{payload[:message].group.id}:messages",
      message: render_message(payload[:message])
      # date: render_date(payload[:new_date])
      )
  end

  private

  def render_message(message)
    ApplicationController.renderer.render(
      partial: 'messages/message',
      locals: { message: message }
      )
  end

  # def render_date(new_date)
  #   if new_date
  #     return ApplicationController.renderer.render(
  #             partial: 'messages/message_date',
  #             locals: { date: "Today" }
  #             )
  #   else
  #     return ''
  #   end
  # end
end
