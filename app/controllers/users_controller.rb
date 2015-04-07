class UsersController < ApplicationController
  
  def show
    @languages = current_user.user_languages
  end

end
