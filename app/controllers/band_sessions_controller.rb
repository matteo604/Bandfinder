class BandSessionsController < ApplicationController
  before_action :set_band_session, only: %i[show edit update]

  def index
    @band_sessions = BandSession.all
  end

  def show
    @band = Band.find(params[:band_id])
    @band_session = @band.band_sessions.find(params[:id])
  end

  def new
    @band_session = BandSession.new
    @band = Band.find(params[:band_id])
  end

  def create
    @band = Band.find(params[:band_id])
    @band_session = BandSession.new(band_session_params)
    @band_session.band_id = @band.id
    @band_session.creator_id = current_user.id
    if @band_session.save
      redirect_to band_band_sessions_path, notice: 'Session was successfully created.'
      puts "Session valid"
    else
      render 'bands/show', status: :unprocessable_entity
      puts @band_session.errors.full_message
    end
  end

  def edit
  end

  def update
    if @band_session.update(band_session_params)
      redirect_to @band_session, notice: 'Session was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_band_session
    @band_session = BandSession.find(params[:id])
  end

  def band_session_params
    params.require(:band_session).permit(:title, :description, :address, :start_date, :end_date)
  end

end
