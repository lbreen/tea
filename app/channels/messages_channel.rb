class MessagesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "group-#{params[:group_id]}:messages"
  end

  def receive(payload)
    Message.create(
      content: payload['content'],
      group_id: params['group_id'],
      user: current_user
    )
  end
end
