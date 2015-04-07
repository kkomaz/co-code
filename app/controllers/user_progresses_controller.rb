class UserProgressesController < ApplicationController
  def create
    # capture language id and get the correct languageproblem id for the first problem
    @language_problem = LanguageProblem.find_language_problem(params[:language][:id], params[:id])
    # then create user progress using current user and above lp id
    @user_progress = UserProgress.build_user_progress(@language_problem, current_user)
    # save
    if @user_progress.save
      #redirect to show
      redirect_to progress_path(@language_problem.language)
    else
      redirect_to :back
    end

  end

  def show
    @language = Language.find(params[:id])
  end

  def update
  end
end
