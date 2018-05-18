class MessagesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "group-#{params[:group_id]}:messages"
  end
end
