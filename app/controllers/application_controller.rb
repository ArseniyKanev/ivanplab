class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }

  before_action :set_locale

  def set_locale
    I18n.locale = :ru
  end

  def error404
    render status: :not_found
  end

  private

  def after_sign_in_path_for(resource_or_scope)
    download_path
  end

  def after_sign_out_path_for(resource_or_scope)
    "https://landing.ivanplab.ru"
  end
end
