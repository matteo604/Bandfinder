class BandsController < ApplicationController

  def index
    @current_user_band = current_user.band
    if current_user.band
      @bands = Band.where.not(id: @current_user_band.id)
    else
      @bands = Band.all
    end
  end

  def new
    @band = Band.new
  end

  def show
    @band = Band.find(params[:id])
    @band_session = BandSession.new
    @members = @band.members
  end

  def my_band
    #@band = current_user.band
    @band = Band.find(params[:band_id])
    @band_sessions = @band.band_sessions
    @band_session = BandSession.new
    #@band_session.user = current_user
    @members = @band.members
    @join_requests = @band.join_requests.where(status: "pending")
  end

  def create
    @band = Band.new(band_params)

    # Set the current user as the leader of the band
    @band.leader = current_user
    if @band.save
      # Set the current user as a member of the band
      current_user.update(band: @band)
      redirect_to band_path(@band), notice: "Band was successfully created."
    else
      render 'bands/new', status: :unprocessable_entity
    end
  end

  def edit
    @band = Band.find(params[:id])
  end

  def update
    @band = Band.find(params[:id])
    if params[:band][:searching_for_instruments].is_a?(Array)
      non_blank_instruments = params[:band][:searching_for_instruments].reject(&:blank?).map(&:strip)
      params[:band][:searching_for_instruments] = non_blank_instruments
    end
    if @band.update(band_params)
      redirect_to @band, notice: 'Band was successfully updated.'
    else
      render :edit, alert: 'Band was not updated.'
    end
  end



  def destroy
    @band = Band.find(params[:id])
    @band.members.update_all(band_id: nil)
    @band.destroy
   redirect_to controller: 'pages', action: 'home', notice: 'Band was successfully deleted.'
  end

  private

  def band_params
    params.require(:band).permit(:title, :description, :address, :genre, :photo, searching_for_instruments: [])
  end
end
