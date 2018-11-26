class ApplicationController < ActionController::Base
  before_action :must_be_logged_in
  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find_by(id: session[:user])
  end

  def logged_in?
    if current_user.present?
      return true
    else
      return false
    end

    # or
    # current_user != nil
  end

  def must_be_logged_in
    redirect_to external_root_path unless logged_in?
  end
end
