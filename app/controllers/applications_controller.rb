class ApplicationsController < ApplicationController
  before_action :set_application, only: [:destroy]
  before_action :set_band_session, only: [:create]

  def create
    @application = Application.new
    @application.band.session_id = @band_session.id
    @application.band_id = @band_session.band_id
    @application.user_id = current_user.id
    @application.status = "pending"

    if @application.save
      redirect_to session_path(@session), notice: 'Application was successfully created.'
    else
      redirect_to session_path(@session), alert: 'Failed to create application.'
    end
  end

  def destroy
    if @application.destroy
      redirect_to band_session_path(@application.band_session), notice: 'Application was successfully deleted.'
    else
      redirect_to band_session_path(@application.band_session), alert: 'Failed to delete application.'
    end
  end

  private

  def set_application
    @application = Application.find(params[:id])
  end

  def set_band_session
    @band_session = BandSession.find(params[:session_id])
  end
end
