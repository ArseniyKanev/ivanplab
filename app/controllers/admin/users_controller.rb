class Admin::UsersController < ApplicationController
  layout "admin"
  before_action :is_admin?

  def index
    @users = User.order(created_at: :desc)
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to admin_users_path
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save!
      redirect_to admin_users_path
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update!(user_params)
    redirect_to admin_users_path
  end

  def is_admin?
    redirect_to root_path unless current_user.admin?
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :phone, :password, :password_confirmation)
  end

end
