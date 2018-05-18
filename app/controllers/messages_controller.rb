class MessagesController < ApplicationController
  before_action :find_group, only: [ :create ]

  def create
    @message = Message.new(message_params)
    @message.group = @group
    @message.user = current_user
    authorize @message
    if @message.save
      ActionCable.server.broadcast "group-#{@group.id}:messages",
        content: @message.content,
        first_name: @message.user.first_name,
        created_at: @message.created_at.strftime('%H:%M'),
        group_id: @group.id
      head :ok
    else
      redirect_to group_path(@group)
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
