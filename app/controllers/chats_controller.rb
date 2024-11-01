class ChatsController < ApplicationController
  before_action :set_chat, only: [:show, :destroy]

  def index
    # load chats with unread messages first, sort by the most recent message timestamp
    @chats_with_unread_messages = Chat.joins(:messages)
                                      .where("(chats.user_id = :user_id OR chats.band_leader_id = :user_id) AND messages.read = false", user_id: current_user.id)
                                      .order('messages.created_at DESC')

    # looad remaining chats, excluding those with unread messages, sorted by the last activity timestamp
    @chats_without_unread_messages = Chat.where("user_id = :user_id OR band_leader_id = :user_id", user_id: current_user.id)
                                        .where.not(id: @chats_with_unread_messages.select(:id))
                                        .order('updated_at DESC')

    # combne both lists to display chats with unread messages first, followed by the rest
    @chats = @chats_with_unread_messages + @chats_without_unread_messages
  end

  def show
    @chat = Chat.find(params[:id])
    @chat.messages.where(read: false).where.not(user_id: current_user.id).update_all(read: true)
  end

  def new
    if params[:band_id]
      @band = Band.find(params[:band_id]) # find the band based on the band_id parameter
    elsif params[:user_id]
      @user = User.find(params[:user_id]) # find the user based on the user_id parameter
    end
    @chat = Chat.new # initialize a new chat
  end

  def create
    if params[:band_id]
      @band = Band.find(params[:band_id]) # find the band based on the band_id parameter
      @band_leader = @band.leader # get the band leader of the band

      # find or initialize a chat between the current user and the band leader
      @chat = Chat.find_or_initialize_by(user_id: current_user.id, band_leader_id: @band_leader.id)

      # set band_id for the new chat if the chat is new
      @chat.band_id = @band.id if @chat.new_record?
    elsif params[:user_id]
      @user = User.find(params[:user_id]) # find the user based on the user_id parameter

      # find or initialize a chat between the current user and the other user
      @chat = Chat.find_or_initialize_by(user_id: current_user.id, band_leader_id: @user.id)
    end

    if @chat.save
      redirect_to @chat, notice: 'Chat was successfully created or continued.'
    else
      flash.now[:alert] = @chat.errors.full_messages.join(", ")
      render :new
    end
  end

  def destroy
    if @chat.user_id == current_user.id # corrected condition from = to ==
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
