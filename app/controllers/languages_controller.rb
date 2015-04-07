class LanguagesController < ApplicationController

  def index
    @language = Language.new
    @languages = current_user.available_user_languages
  end

end
