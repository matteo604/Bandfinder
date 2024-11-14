class ChatsController < ApplicationController
  before_action :set_chat, only: [:show, :destroy]

  def index
    # load chats with unread messages first, sorted by most recent message timestamps
    @chats_with_unread_messages = Chat.joins(:messages)
                                      .where("(chats.user_id = :user_id OR chats.band_leader_id = :user_id) AND messages.read = false", user_id: current_user.id)
                                      .order('messages.created_at DESC')

    # load remaining chats, excluding those with unread messages, sorted by the last activity timestamp
    @chats_without_unread_messages = Chat.where("user_id = :user_id OR band_leader_id = :user_id", user_id: current_user.id)
                                        .where.not(id: @chats_with_unread_messages.select(:id))
                                        .order('updated_at DESC')

    # combine both lists to display chats with unread messages first, followed by the rest
    @chats = @chats_with_unread_messages + @chats_without_unread_messages
  end

  def show
    @chat = Chat.find(params[:id])
    # mark messages from the other user as read
    @chat.messages.where(read: false).where.not(user_id: current_user.id).update_all(read: true)

    # find the band leader and the corresponding band
    @band_leader = @chat.band_leader
    @band = Band.find_by(leader_id: @band_leader.id) # get the band associated with the band leader
  end

  def new
    if params[:band_id]
      @band = Band.find_by(id: params[:band_id]) # find the band based on the band_id parameter
      if @band.present? && @band.leader_id == current_user.id
        redirect_to bands_path, alert: 'You cannot start a chat with your own band.'
        return
      end
    elsif params[:user_id]
      @user = User.find_by(id: params[:user_id]) # find the user based on the user_id parameter
    end
    @chat = Chat.new # initialize a new chat
  end

  def create
    if params[:chat].present? && params[:chat][:band_leader_id].present?
      @band_leader = User.find_by(id: params[:chat][:band_leader_id]) # find the band leader as a user based on the band_leader_id parameter
      if @band_leader.nil?
        redirect_to bands_path, alert: 'Band Leader not found. Please try again.'
        return
      end

      # prevent band leader from starting a chat with their own band
      if @band_leader.id == current_user.id
        redirect_to bands_path, alert: 'You cannot start a chat with your own band.'
        return
      end

      # find or initialize a chat between the current user and the band leader
      @chat = Chat.find_or_initialize_by(user_id: [current_user.id, @band_leader.id].min, band_leader_id: [current_user.id, @band_leader.id].max)

    elsif params[:chat].present? && params[:chat][:user_id].present?
      @user = User.find_by(id: params[:chat][:user_id]) # find the user based on the user_id parameter
      if @user.nil?
        redirect_to users_path, alert: 'User not found. Please try again.'
        return
      end

      # find or initialize a chat between the current user and the other user
      @chat = Chat.find_or_initialize_by(user_id: [current_user.id, @user.id].min, band_leader_id: [current_user.id, @user.id].max)
    else
      # if neither band_leader_id or user_id is provided
      redirect_to chats_path, alert: 'Unable to create chat. Missing required parameters.'
      return
    end

    if @chat.save
      redirect_to @chat
    else
      flash.now[:alert] = @chat.errors.full_messages.join(", ")
      render :new
    end
  end

  def destroy
    if @chat.user_id == current_user.id # only allow the user who initiated the chat to delete it
      @chat.destroy
      redirect_to chats_path, notice: 'Chat was successfully deleted.'
    else
      redirect_to @chat, alert: 'You are not able to delete this chat.'
    end
  end

  def unread_count
    unread_count = Chat.joins(:messages)
                      .where("(chats.user_id = :user_id OR chats.band_leader_id = :user_id) AND messages.read = false AND messages.user_id != :user_id", user_id: current_user.id)
                      .count
    render json: { unread_count: unread_count }
  end

  def unread_count_per_chat
    # Calculates the unread messages per chat for the current user
    unread_counts = Chat.joins(:messages)
                        .where("(chats.user_id = :user_id OR chats.band_leader_id = :user_id) AND messages.read = false AND messages.user_id != :user_id", user_id: current_user.id)
                        .group("chats.id")
                        .count("messages.id")

    render json: unread_counts
  rescue => e
    render json: { error: e.message }, status: :internal_server_error
  end

  # Mark all messages in all chats as read for the current user
  def mark_all_as_read
    Chat.where("user_id = :user_id OR band_leader_id = :user_id", user_id: current_user.id).each do |chat|
      chat.messages.where(read: false).where.not(user_id: current_user.id).update_all(read: true)
    end

    render json: { success: true }
  rescue ActiveRecord::RecordNotFound
    render json: { success: false, error: "Chat not found" }, status: :not_found
  end

  private

  def set_chat
    @chat = Chat.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to chats_path, alert: 'Chat does not exist.'
  end
end
