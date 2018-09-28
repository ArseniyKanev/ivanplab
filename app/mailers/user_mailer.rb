class UserMailer < ApplicationMailer
  default from: "admin@ivanplab.ru"

  def user_email(user)
    @user = user
    mail(to: "admin@ivanplab.ru", subject: "Удаление пользователя")
  end
end
