class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  def index
    @users = User.where.not(id: current_user.id)
  end

  def show
    @band = Band.find_by(leader_id:current_user.id)
    @bands = Band.all
  end

  def edit
  end

  def update
    # Debug: verifica che params[:user] sia presente e abbia la chiave :instruments
    Rails.logger.debug("User params: #{params[:user].inspect}")

    # Assicurati che instruments sia un array e manipola i dati
    if params[:user][:instruments].is_a?(Array)
      Rails.logger.debug("Initial instruments array: #{params[:user][:instruments].inspect}")

      # Rimuovi valori vuoti e spazi bianchi
      non_blank_instruments = params[:user][:instruments].reject(&:blank?).map(&:strip)
      Rails.logger.debug("Non-blank instruments array after strip: #{non_blank_instruments.inspect}")

      # Unisci gli strumenti in una stringa
      params[:user][:instruments] = non_blank_instruments.join(", ")
      Rails.logger.debug("Final instruments string: #{params[:user][:instruments]}")
    end

    # Verifica se l'aggiornamento del user va a buon fine
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

  private
  def set_user
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :telephone_number, :address, :instruments)
  end

end
