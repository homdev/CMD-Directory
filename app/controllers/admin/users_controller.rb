class Admin::UsersController < ApplicationController
  layout 'admin'
  before_action :authenticate_user!
  before_action :authorize_admin
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = policy_scope([:admin, User])
    authorize [:admin, User]
  end

  def show
    authorize [:admin, @user]
  end

  def new
    @user = User.new
    authorize [:admin, @user]
  end

  def create
    @user = User.new(user_params)
    authorize [:admin, @user]

    if @user.save
      redirect_to admin_user_path(@user), notice: "L'utilisateur a été créé avec succès."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize [:admin, @user]
  end

  def update
    authorize [:admin, @user]
    if @user.update(user_params)
      flash[:notice] = "L'utilisateur a été mis à jour avec succès."
      redirect_to admin_user_path(@user)
    else
      flash[:alert] = "Échec de la mise à jour de l'utilisateur."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize [:admin, @user]
    @user.destroy
    redirect_to admin_users_path, notice: "L'utilisateur a été supprimé avec succès."
  end

  private

  def authorize_admin
    unless current_user.admin?
      redirect_to(root_path, alert: "Accès refusé")
    end
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :role, :profile_image, :banner_image, :name, :surname, :username, :address, :city, :country, :profession, :phone_number)
  end
end
