class UserProgressesController < ApplicationController
  def create
    @language = Language.find(params[:language][:id])
    LanguageProblem.assign_all_problems(current_user, params[:language][:id])
    UserProgress.set_first_problem_as_current(current_user, params[:language][:id])

    redirect_to progress_path(@language)
  end

  def show
    @language = Language.find(params[:id])
    @current_problem = current_user.current_problem(@language)
  end

  def update
    @language_problem = LanguageProblem.find_language_problem(params[:language][:id], params[:id])
    @language = @language_problem.language
    @user_progress = UserProgress.progress_for_user(current_user, @language_problem)
    if params[:user_progress][:status]
      current_user.change_current_problem(@user_progress) # => change user's current problem
    end
    @user_progress.update(user_progress_params)
    redirect_to language_problem_path(@language, current_user.current_problem(@language))
  end

  private
    def user_progress_params
      params.require(:user_progress).permit(:status, :favorite)
    end

end
