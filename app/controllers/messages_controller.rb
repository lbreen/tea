class MessagesController < ApplicationController
  protect_from_forgery except: :index
  before_action :find_group, only: [ :index, :create ]

  def index
    @messages = policy_scope(Message).reverse_order.page(params[:page])

    @rendered_messages = @messages.map do |message|
      ApplicationController.renderer.render(
        partial: 'messages/message',
        locals: { message: message, user_is_author: current_user == message.user }
      )
    end

    respond_to do |format|
      format.html { redirect_to group_path(@group) }
      format.js
    end
  end

  def create
    @message = Message.new(message_params)
    @message.group = @group
    @message.user = current_user
    authorize @message
    if @message.save
      respond_to do |format|
        format.html { redirect_to group_path(@group) }
        format.js
      end
    else
      respond_to do |format|
        format.html { render 'groups/show' }
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

  def pundit_user
    @group
  end
end
