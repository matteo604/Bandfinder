class UsersController < ApplicationController
  def index
    @users = User.where.not(id: current_user.id)
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.id = current_user.id
      @user.destroy
      redirect_to 'bands#index', notice: 'Your account was successfully deleted.'
    else
       redirect_to 'bands#index', alert: 'You are not able to delete this account.'
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :instruments, :address, :email, :telephone_number)
  end
end
