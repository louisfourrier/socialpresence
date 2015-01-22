class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :set_locale
  
  private
  
  # Set the language
  def set_locale
      I18n.locale = I18n.default_locale
  end
  
  # For all the link_to
  def default_url_options(options={})
  { locale: I18n.locale }
  end
  
end
