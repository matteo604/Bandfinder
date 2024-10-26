class BandsController < ApplicationController
  def index
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
    @band = Band.find(params[:id])
  end

  def update
    if @band.update(band_params)
      redirect_to @band, notice: 'Band was successfully updated.'
    else
      render :edit, alert: 'Band was not updated.'
    end
  end

  def destroy
    @band = Band.find(params[:id])
    @band.destroy
    redirect_to_bands_path, notice: 'Band was successfully deleted.'
  end
end
