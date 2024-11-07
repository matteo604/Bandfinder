class MessagesController < ApplicationController
  before_action :set_chat
  before_action :set_message, only: [:update, :destroy]

  def index
    @messages = @chat.messages.includes(:user).order(created_at: :asc)
  end

  def create
    @message = @chat.messages.build(message_params)
    @message.user_id = current_user.id

    if @message.save
      respond_to do |format|
        format.html { redirect_to chat_path(@chat)}
        format.json { render json: { success: true, message: @message } }
      end
    else
      respond_to do |format|
        format.html { render :new }
        format.json { render json: { success: false }, status: :unprocessable_entity }
      end
    end
  end

  def update
    if @message.update(message_params)
      respond_to do |format|
        format.json { render json: { success: true, content: @message.content, edited: @message.updated_at != @message.created_at } }
        format.html { redirect_to chat_path(@chat), notice: 'Message was successfully updated.' }
      end
    else
      respond_to do |format|
        format.json { render json: { success: false }, status: :unprocessable_entity }
        format.html { render :edit }
      end
    end
  end

  def destroy
    if @message.user_id == current_user.id
      @message.update(content: "This message was deleted by the author.")
      respond_to do |format|
        format.json { render json: { success: true, message_id: @message.id, content: @message.content, deleted: true } }
        format.html { redirect_to chat_path(@chat), notice: 'Message was successfully deleted.' }
      end
    else
      respond_to do |format|
        format.json { render json: { success: false }, status: :forbidden }
        format.html { redirect_to chat_path(@chat), alert: 'You are not authorized to delete this message.' }
      end
    end
  end

  def check_updates
    @new_messages = @chat.messages.where('created_at > ?', 10.seconds.ago)
    @updated_messages = @chat.messages.where('updated_at > ?', 10.seconds.ago)
    render json: {
      new_messages: @new_messages.as_json(only: [:id, :content, :created_at, :user_id], methods: :user_name),
      updated_messages: @updated_messages.as_json(only: [:id, :content], methods: :edited?)
    }
  end


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
