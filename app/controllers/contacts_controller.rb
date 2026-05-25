class ContactsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create

  def create
    return head(:ok) if params[:website].present?

    name    = params[:name].to_s.strip
    email   = params[:email].to_s.strip
    company = params[:company].to_s.strip
    message = params[:message].to_s.strip

    if message.blank? || (name.blank? && email.blank?)
      render json: { ok: false, error: 'Заполните, пожалуйста, форму.' },
             status: :unprocessable_entity
      return
    end

    ContactMailer.notify(
      name: name, email: email, company: company, message: message
    ).deliver_now

    render json: { ok: true }
  rescue => e
    Rails.logger.error("ContactMailer failed: #{e.class}: #{e.message}")
    render json: { ok: false, error: 'Не удалось отправить. Попробуйте позже.' },
           status: :internal_server_error
  end
end
