class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :set_locale

  private
  def set_locale
    I18n.locale = session[:locale] || I18n.default_locale
    session[:locale] = I18n.locale
  end
end
