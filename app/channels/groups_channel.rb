class GroupsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "group_#{params[:group_id]}"
  end
end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
