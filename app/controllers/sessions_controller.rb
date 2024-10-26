class SessionController < ApplicationController
  before_action :set_session, only: %i[show edit update]

  def index
    @sessions = Session.all
  end

  def show
  end

  def new
    @session = Session.new
  end

  def create
    @session = Session.new(session_params)
    @band = Band.find(params[:band_id])
    @session.band_id = @band.id
    @session.creator_id = currest_user.id
    if @session.save
      redirect_to @session, notice: 'Session was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @session.update(session_params)
      redirect_to @session, notice: 'Session was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_session
    @session = Session.find(params[:id])
  end

  def session_params
    params.require(:session).permit(:title, :description, :address, :start_date, :end_date)
  end

end
