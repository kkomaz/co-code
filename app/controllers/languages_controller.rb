class LanguagesController < ApplicationController

  def index
    @language = Language.new
    @languages = Language.all
  end

end
