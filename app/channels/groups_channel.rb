class GroupsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "group_#{params[:group_id]}"
  end
end
