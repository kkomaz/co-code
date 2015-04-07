class LanguagesController < ApplicationController
  
  def index
    @language = Language.new
    @user = User.find(current_user.id)
    @languages = Language.all
  end

  def create
    @user = User.find(params[:user_id])

  end

end
