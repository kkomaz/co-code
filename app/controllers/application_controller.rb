class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_filter :set_cache_buster

  rescue_from ActionController::RoutingError, :with => :error_404_render_method
  rescue_from Exception, :with => :error_404_render_method

  def error_404_render_method
    render :template => "public/404", :status => 404, :layout => false
    true
  end


  def set_cache_buster
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end
end
