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
    @markers = [
      {
        lat: @band.latitude,
        lng: @band.longitude,
        info_window: render_to_string(partial: "bands/band_popup", locals: { band: @band}),
        marker_html: "<i class='fa-duotone fa-solid fa-people-group' style='color: black; font-size: 30px;'></i>"
      }
    ]
  end

  def my_band
    @band = Band.find(params[:band_id])
    @band_sessions = @band.band_sessions
    @band_session = BandSession.new
    @members = @band.members
    @join_requests = @band.join_requests.where(status: "pending", join_type: "user_to_band")
  end

  def create
    @instruments_array = params[:band][:searching_for_instruments].downcase.split(", ")
    @band = Band.new(band_params)
    @band.searching_for_instruments = @instruments_array
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
    @instruments_array = params[:band][:searching_for_instruments].downcase.split(", ")
    if @band.update(band_params)
      @band.update(searching_for_instruments: @instruments_array)
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
    params.require(:band).permit(:title, :description, :address, :genre, :photo, :searching_for_instruments)
  end
end
