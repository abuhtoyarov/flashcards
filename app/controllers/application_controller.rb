require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  protect_from_forgery with: :exception
  before_action :set_locale

  private

  def set_locale
    if locale_defined?(get_locale)
      session[:locale] = I18n.locale = get_locale
    else
      session[:locale] = I18n.locale = I18n.default_locale
    end
  end

  def get_locale
    return current_user.locale if current_user
    language = http_accept_language.compatible_language_from(I18n.available_locales)
    params[:user_locale] || session[:locale] || language
  end

  def default_url_options(options = {})
    { locale: I18n.locale }.merge options
  end

  def locale_defined?(locale)
    I18n.available_locales.include?(locale.try(:to_sym))
  end
end
