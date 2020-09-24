class ApplicationController < ActionController::Base
  rescue_from ActionController::RoutingError, with: :rescue_404_exception
  rescue_from CanCan::AccessDenied, with: :rescue_can3_exception

  include SessionsHelper
  include UsersHelper
  include TableHelper
  include SubjectsHelper
  include UiCustomHelper

  before_action :set_locale

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def find_user
    @user = User.find_by id: params[:id] if params[:id]
    return if @user

    flash[:danger] = t "users.please_login"
    redirect_to root_url
  end

  def rescue_can3_exception
    respond_to do |format|
      format.json{head :forbidden}
      format.html do
        render file: Rails.root.join("public", "404.html").to_s, layout: false,
               status: :not_found
      end
    end
  end

  def rescue_404_exception
    respond_to do |format|
      format.json{head :not_found}
      format.html do
        render file: Rails.root.join("public", "404.html").to_s, layout: false,
               status: :not_found
      end
    end
  end
end
