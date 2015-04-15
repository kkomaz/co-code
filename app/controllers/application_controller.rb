class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  # def redirect_to(options = {}, response_status = {})
  #   if request.xhr?
  #     render(:update) {|page| page.redirect_to(options)}
  #   else
  #     super(options, response_status)
  #   end
  # end
end
