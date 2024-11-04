class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  def index
    @users = User.where.not(id: current_user.id)
  end

  def show
    @band = Band.all
  end

  def edit

  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    if @user.id = current_user.id
      @user.destroy
      redirect_to 'bands#index', notice: 'Your account was successfully deleted.'
    else
       redirect_to 'bands#index', alert: 'You are not able to delete this account.'
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end
  def user_params
    params.require(:user).permit(:first_name, :last_name, :instruments, :address, :email, :telephone_number)
  end
end
