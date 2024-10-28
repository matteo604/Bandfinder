class ChatsController < ApplicationController
  before_action :set_chat, only: [:show, :destroy]
  def index
    @chats = Chat.where("user_id = :user_id OR band_leader_id = :user_id", user_id: current_user.id)
  end

  def show
  end

  def new
    @chat = Chat.new
  end

  def create
    @chat = Chat.new
    @chat.user_id = current_user.id
    if @chat.save
      redirect_to @chat, notice: 'Chat was successfully created.'
    else
      render :new
    end
  end

  def destroy
    if @chat.user_id = current_user.id
     @chat.destroy
     redirect_to chats_path, notice: 'Chat was successfully deleted.'
    else
       redirect_to @chat, alert: 'You are not able to delete this chat.'
    end
  end

  private

  def set_chat
    @chat = Chat.find(params[:id])
  end

end
