class UsersController < ApplicationController

  def show
    @language = Language.new
    @current_languages = current_user.user_languages
    @languages = current_user.available_user_languages
  end

end
