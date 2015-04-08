class UserProgressesController < ApplicationController
  def create
    @language = Language.find(params[:language][:id])
    LanguageProblem.assign_all_problems(current_user, params[:language][:id])
    UserProgress.set_first_problem_as_current(current_user, params[:language][:id])

    redirect_to progress_path(@language)

    # @language_problem = LanguageProblem.find_language_problem(, params[:id])
    # @user_progress = UserProgress.find_or_build_user_progress(@language_problem, current_user)

    # if !current_user.new_user?(@language_problem.language)
    #   current_user.replace_current_problem(@language_problem.language)
    #   @user_progress.save
    #   redirect_to :back
    # elsif @user_progress.save
    #   redirect_to progress_path(@language_problem.language)
    # else
    #   redirect_to :back
    # end

  end

  def show
    @language = Language.find(params[:id])
    @current_problem = current_user.current_problem(@language)
  end

  def update
    @language_problem = LanguageProblem.find_language_problem(params[:language][:id], params[:id])
    @language = @language_problem.language
    @user_progress = UserProgress.progress_for_user(current_user, @language_problem)
    current_user.change_current_problem(@user_progress) # => change user's current problem

    @user_progress.update(user_progress_params)
    redirect_to language_problem_path(@language, current_user.current_problem(@language))

  end

  private
    def user_progress_params
      params.require(:user_progress).permit(:status)
    end

end
