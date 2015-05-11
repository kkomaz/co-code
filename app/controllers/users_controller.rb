class UsersController < ApplicationController

  def show
    @language = Language.new
    @current_languages = current_user.user_languages
    @languages = current_user.available_user_languages
  end

  def profile
    @user = User.find(params[:id])
  end
end
