class JoinRequestsController < ApplicationController

  def create
    if params[:band_id]
      @band = Band.find(params[:band_id])
      @join_request = @band.join_requests.build(join_request_params_for_user)
      if @join_request.save
        redirect_to band_path(@join_request.band), notice: 'Request was successfully sent.'
      else
        render 'pages#home', status: :unprocessable_entity
      end
    elsif params[:user_id]
      @user = User.find(params[:user_id])
      @join_request = @user.join_requests.build(join_request_params_for_band)
      if @join_request.save
        redirect_to band_path(@join_request.user), notice: 'Request was successfully sent.'
      else
        render 'pages#home', status: :unprocessable_entity
      end
    else
       redirect_to 'pages#home', alert: 'Unauthorized action'
    end
  end

  def accept
    @join_request = JoinRequest.find(params[:id])
    @join_request.update(status: "accepted")
    if @join_request.save
      add_member(@join_request.user_id)
      redirect_to user_join_requests_path(@join_request.user), notice: 'Join request accepted.'
    else
      redirect_to band_join_requests_path(@join_request.band), alert: 'Unable to accept request.'
    end
  end

  def decline
    @join_request = JoinRequest.find(params[:id])

    @join_request.update(status: "declined")
    if @join_request.save
      redirect_to join_requests_path, notice: 'Join request declined.'
    else
      redirect_to join_requests_path, alert: 'Unable to decline request.'
    end
  end

  private

  def add_member(id)
    if @join_request.join_type == "user_to_band" || @join_request.join_type == "band_to_user"
      user = @join_request.user
      user.band_id = @join_request.band.id
      user.save
    else
      redirect_to "pages#home", alert: 'Join request has no valid join_type'
    end
  end


  def join_request_params_for_user
    params.require(:join_request).permit(:join_type).merge(user_id: current_user.id)
  end

  def join_request_params_for_band
    params.require(:join_request).permit(:join_type).merge(band_id: current_user.band_id)
  end

end
