class UserProgressesController < ApplicationController
  def create
    @language_problem = LanguageProblem.find_language_problem(params[:language][:id], params[:id])
    @user_progress = UserProgress.find_or_build_user_progress(@language_problem, current_user)
    current_user.replace_current_problem(@language_problem.language)
    if @user_progress.save && current_user.new_user?(@language_problem.language)
      redirect_to progress_path(@language_problem.language)
    else
      redirect_to :back
    end

  end

  def show
    @language = Language.find(params[:id])
    @current_problem = current_user.current_problem(@language)
  end

  def update
  end
end
