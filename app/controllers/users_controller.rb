class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized, except: [:index, :show]

  def index
    @users = User.all
    authorize @users
  end

  def show
    authorize @user
  end

  def new
    @user = User.new
    authorize @user
  end

  def create
    @user = User.new(user_params)
    authorize @user
    if @user.save
      redirect_to @user, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  def edit
    @user = current_user
    authorize @user
  end

  def update
    @user = current_user
    authorize @user

    Rails.logger.debug { "Params received: #{user_params.inspect}" }

    if @user.update(user_params)
      Rails.logger.debug { "User updated successfully: Profile image attached? #{@user.profile_image.attached?}, Banner image attached? #{@user.banner_image.attached?}" }
      flash[:success] = "Profile successfully updated"
      redirect_to edit_user_path(@user)
    else
      Rails.logger.error { "Failed to update user: #{@user.errors.full_messages}" }
      flash[:error] = "Failed to update profile"
      render :edit
    end
  end
  
  def destroy
    authorize @user
    @user.destroy
    redirect_to users_url, notice: 'User was successfully destroyed.'
  end

  private

  def set_user
    @user = User.find(params[:id])
    Rails.logger.debug { "Set user: #{@user.inspect}" }
    redirect_to root_path, alert: "Invalid user ID" unless @user
  end

  def user_params
    params.require(:user).permit(:email, :password, :role, :profile_image, :banner_image, :name, :surname, :username, :address, :city, :country, :profession, :phone_number)
  end
end
