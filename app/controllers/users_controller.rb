class UsersController < ApplicationController

  def show
    @language = Language.new
    @current_languages = current_user.user_languages
    @languages = current_user.available_user_languages
  end

  def status
    @online_users = User.online
    @path = online_users_path
  end

  def online_user
  end

end
