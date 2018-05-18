class MessagesController < ApplicationController
  before_action :find_group, only: [ :create ]

  def create
    @message = Message.new(message_params)
    @message.group = @group
    @message.user = current_user
    authorize @message
    if @message.save
      ActionCable.server.broadcast "group-#{@group.id}:messages",
        message: @message
      head :ok
    else
      respond_to do |format|
        format.html { redirect_to groups_path(@group) }
        format.js
      end
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end

  def find_group
    @group = Group.find(params[:group_id])
  end
end
