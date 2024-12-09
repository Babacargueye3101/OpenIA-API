class ApplicationController < ActionController::Base
  before_action :set_locale

  private

  def set_locale
    I18n.locale = extract_locale_from_accept_language || I18n.default_locale
  end

  def extract_locale_from_accept_language
    language = request.env['HTTP_ACCEPT_LANGUAGE'].to_s.scan(/^[a-z]{2}/).first
    I18n.available_locales.map(&:to_s).include?(language) ? language : nil
  end

end
