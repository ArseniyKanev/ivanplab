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
    redirect_to is_admin? ? admin_users_url : root_path
  end

  def is_admin?
    redirect_to root_path unless current_user.admin?
  end

end
