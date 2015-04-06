class UsersController < ApplicationController
  
  def show
    @languages = current_user.active_languages
  end
end
