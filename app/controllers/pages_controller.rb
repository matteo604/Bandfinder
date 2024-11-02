class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home,:search ]

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

  def search
    # Set button states based on incoming parameters
    @button_status = params[:status] == "on" ? "map-view" : "list-view"
    @button_state = params[:state] == "on"

    case params[:form_type]
    when "user_search"
      handle_user_search
    when "band_search"
      handle_band_search
    else
      @users = []
      @bands = []
    end

    render :home
  end

  private

  def handle_user_search
    @users = User.all
    filter_user_search

    # Generate markers only if there are users found
    @markers = @users.geocoded.map do |user|
      {
        lat: user.latitude,
        lng: user.longitude,
        marker_html: "<i class='fas fa-map-marker-alt' style='color: black; font-size: 30px;'></i>"
      }
    end
    @bands = []
  end

  def filter_user_search
    first_name = params[:first_name]
    last_name = params[:last_name]
    address = params[:address]
    instruments = params[:instruments]
    status = params[:status]

    @users = @users.where("first_name ILIKE ?", "%#{first_name}%") if first_name.present?
    @users = @users.where("last_name ILIKE ?", "%#{last_name}%") if last_name.present?
    @users = @users.where("address ILIKE ?", "%#{address}%") if address.present?
    @users = @users.where("instruments ILIKE ?", "%#{instruments}%") if instruments.present?
    @users = @users.where("status ILIKE ?", "%#{status}%") if status.present?
  end

  def handle_band_search
    @bands = Band.all
    filter_band_search

    # Generate markers only if there are bands found
    @markers = @bands.geocoded.map do |band|
      {
        lat: band.latitude,
        lng: band.longitude,
        marker_html: "<i class='fas fa-map-marker-alt' style='color: black; font-size: 30px;'></i>"
      }
    end
    @users = []
  end

  def filter_band_search
    address = params[:band_address]
    genre = params[:genre]
    searching_for_instruments = params[:searching_for_instruments]

    Rails.logger.debug "Address: #{address}"
    @bands = @bands.where("address ILIKE ?", "%#{address}%") if address.present?
    @bands = @bands.where("genre ILIKE ?", "%#{genre}%") if genre.present?
    @bands = @bands.where("searching_for_instruments ILIKE ?", "%#{searching_for_instruments}%") if searching_for_instruments.present?
  end

end
