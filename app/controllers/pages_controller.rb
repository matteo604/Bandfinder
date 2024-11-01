class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :user_search, :band_search ]

  def home
    @users = User.all
    @bands = Band.all
    @band_markers = @bands.geocoded.map do |band|
      {
        lat: band.latitude,
        lng: band.longitude,
        marker_html: "<i class='fas fa-map-marker-alt' style='color: black; font-size: 30px;'></i>"
      }
    end
    @user_markers = @users.geocoded.map do |user|
      {
        lat: user.latitude,
        lng: user.longitude,
        marker_html: "<i class='fas fa-map-marker-alt' style='color: black; font-size: 30px;'></i>"
      }
    end
  end

  def user_search
    first_name = params[:first_name]
    last_name = params[:last_name]
    address = params[:address]
    instruments = params[:instruments]
    status = params[:status]
    @button_state = params[:state] == "on"
    @users = User.all
    @bands = Band.all
    @users = @users.where("first_name ILIKE ?", "%#{first_name}%") if first_name.present?
    @users = @users.where("last_name ILIKE ?", "%#{last_name}%") if last_name.present?
    @users = @users.where("address ILIKE ?", "%#{address}%") if address.present?
    @users = @users.where("instruments ILIKE ?", "%#{instruments}%") if instruments.present?
    @users = @users.where("status ILIKE ?", "%#{status}%") if status.present?
    @user_markers = @users.geocoded.map do |user|
      {
        lat: user.latitude,
        lng: user.longitude,
        marker_html: "<i class='fas fa-map-marker-alt' style='color: black; font-size: 30px;'></i>"
      }
    end
    render :home
  end



  def band_search
    address = params[:address]
    genre = params[:genre]
    searching_for_instruments = params[:searching_for_instruments]

    @bands = Band.all
    @users = User.all
    @bands = @bands.where("address ILIKE ?", "%#{address}%") if address.present?
    @bands = @bands.where("genre ILIKE ?", "%#{genre}%") if genre.present?
    @bands = @bands.where("searching_for_instruments ILIKE ?", "%#{searching_for_instruments}%") if searching_for_instruments.present?
    @band_markers = @bands.geocoded.map do |band|
      {
        lat: band.latitude,
        lng: band.longitude,
        marker_html: "<i class='fas fa-map-marker-alt' style='color: black; font-size: 30px;'></i>"
      }
    end
    render :home
  end

end
