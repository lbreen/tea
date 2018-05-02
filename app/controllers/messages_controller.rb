class MessagesController < ApplicationController
  before_action :find_group, only: [ :create ]

  def create
    @message = Message.new(message_params)
    binding.pry
    @message.group = @group
    @message.user = current_user
    authorize @message
    if @message.save
      ActionCable.server.broadcast 'messages',
        message: @message.content,
        user: @message.user.first_name
      head :ok
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
