class BandsController < ApplicationController

  def index
    @current_user_band = current_user.band
    @bands = Band.where.not(id: current_user_band.id)
  end

  def new
    @band = Band.new
  end

  def show
    @band = Band.find(params[:id])
  end

  def create
    @band = Band.new(band_params)
    @band.leader_id = current_user.id
    if @band.save
      redirect_to band_path(@band), notice "Booking was successfully created."
    else
      render 'bands/show', status :unprocessable_entity
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def band_params
    params.require(:band).permit(:title, :description, :address, :genre)
  end

end
