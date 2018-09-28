class RegistrationsController < Devise::RegistrationsController
  layout 'admin'

  def send_email
    user = User.find(params[:user_id])
    UserMailer.user_email(user).deliver
    flash[:notice] = I18n.t 'delete_request'
    redirect_to root_path
  end

  private

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :email, :phone, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :email, :phone, :password, :password_confirmation, :current_password)
  end
end
