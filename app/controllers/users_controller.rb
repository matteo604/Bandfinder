class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  def index
    @users = User.where.not(id: current_user.id)
  end

  def show
    @band = Band.find_by(leader_id:current_user.id)
    @bands = Band.all
    @join_requests = @user.join_requests
  end

  def edit
  end

  def update
    if params[:user][:photo].present?
      uploaded_file = params[:user][:photo]
      Cloudinary::Uploader.upload(uploaded_file.tempfile.path)
    end

    if params[:user][:instruments].is_a?(Array)
      non_blank_instruments = params[:user][:instruments].reject(&:blank?).map(&:strip)
      params[:user][:instruments] = non_blank_instruments
    end

    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      Rails.logger.debug("User update failed: #{@user.errors.full_messages.inspect}")
      render :edit
    end
  end

  def destroy
    if @user.id = current_user.id
      @user.destroy
      redirect_to 'bands#index', notice: 'Your account was successfully deleted.'
    else
       redirect_to 'bands#index', alert: 'You are not able to delete this account.'
    end
  end

  def delete_photo
    @user = User.find(params[:id])

    if @user.photo.present?
      @user.photo.purge
      flash[:notice] = "Photo deleted successfully."
    else
      flash[:alert] = "No photo to delete."
    end

    redirect_to edit_user_path(@user)
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :telephone_number, :address, :photo, instruments: [])
  end

end
