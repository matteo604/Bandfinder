class ApplicationsController < ApplicationController
  before_action :set_application, only: [:destroy]
  before_action :set_session, only: [:create]
  before_action :set_band, only: [:create]

  def create
    @application = Application.new
    @application.session_id = @session.id
    @application.band_id = @band.id
    @application.user_id = current_user.id
    @application.status = "pending"

    if @application.save
      redirect_to session_path(@session), notice: 'Application was successfully created.'
      @application.status = 'completed'
    else
      redirect_to session_path(@session), alert: 'Failed to create application.'
    end
  end

  def destroy
    if @application.destroy
      redirect_to session_path(@application.session), notice: 'Application was successfully deleted.'
    else
      redirect_to session_path(@application.session), alert: 'Failed to delete application.'
    end
  end

  private

  def set_application
    @application = Application.find(params[:id])
  end

  def set_session
    @session = Session.find(params[:session_id])
  end

  def set_band
    @band = Band.find(params[:band_id])
  end

  def application_params
    params.require(:application).permit(:status)
  end
end
