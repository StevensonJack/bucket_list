class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update]

  def show
    @buckets = @user.buckets
    @bucket = Bucket.new
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :location, :birthday, :email, :password, :current_password, :photo)
  end

  def find_user
    @user = User.find(params[:id])
  end
end
