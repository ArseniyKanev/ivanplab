class ContactMailer < ApplicationMailer
  default to: 'admin@ivanplab.ru'

  def notify(name:, email:, company:, message:)
    @name    = name.to_s.strip
    @email   = email.to_s.strip
    @company = company.to_s.strip
    @message = message.to_s.strip

    subject = "Запрос с сайта от #{@name.presence || 'без имени'}"

    mail(
      from:     'no-reply@ivanplab.ru',
      reply_to: @email.presence,
      subject:  subject
    )
  end
end
