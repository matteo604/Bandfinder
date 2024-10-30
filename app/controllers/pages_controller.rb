class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

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
end
