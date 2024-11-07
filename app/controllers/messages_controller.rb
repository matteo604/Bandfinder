class MessagesController < ApplicationController
  before_action :set_chat
  before_action :set_message, only: [:edit, :update, :destroy]

  def index
    @messages = @chat.messages.includes(:user).order(created_at: :asc)
  end

  def new
    @message = @chat.messages.build
  end

  def create
    @message = @chat.messages.build(message_params)
    @message.user_id = current_user.id

    if @message.save
      redirect_to chat_messages_path(@chat)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @message.update(message_params)
      redirect_to chat_messages_path(@chat), notice: 'Message was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    if @message.user_id = current_user.id
      @message.destroy
      redirect_to chat_messages_path(@chat), notice: 'Message was successfully deleted.'
    else
      redirect_to chat_messages_path(@chat), alert: 'You are not able to delete this message.'
    end
  end

  private

  def set_chat
    @chat = Chat.find(params[:chat_id])
  end

  def set_message
    @message = @chat.messages.find(params[:id])
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
