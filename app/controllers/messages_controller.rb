class MessagesController < ApplicationController
  before_action :find_group, only: [ :index, :create ]

  def index
    @messages = policy_scope(Message).reverse_order.page(params[:page])

    @messages_html = @messages.map do |message|
      ApplicationController.renderer.render(
        partial: 'messages/message',
        locals: { message: message }
      )
    end

    respond_to do |format|
      format.js
      format.html { redirect_to group_path(@group) }
    end
  end

  # def create
    # @message = Message.new(message_params)
    # @message.group = @group
    # @message.user = current_user
    # authorize @message

    # if @message.save!

    # else
    #   respond_to do |format|
    #     format.html { redirect_to group_path(@group) }
    #     format.js
    #   end
    # end
  # end

  private

  def message_params
    params.require(:message).permit(:content)
  end

  def find_group
    @group = Group.find(params[:group_id])
  end

  def pundit_user
    @group
  end
end
