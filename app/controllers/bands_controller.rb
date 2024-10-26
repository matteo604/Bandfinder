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
  end

  def create
    @band = Band.find(params[:id])
    @booking = Booking.new(booking_params)

    if @booking.save
      redirect_to band_path(@band), notice: "Booking was successfully created."
    else
      render 'bands/show', status: :unprocessable_entity
    end
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
    redirect_to bands_path, notice: 'Band was successfully deleted.'
  end

  private

  def band_params
    params.require(:band).permit(:title, :description, :address, :genre)
  end

end
