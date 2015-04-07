class UserProgressesController < ApplicationController
  def create
    # capture language id and get the correct languageproblem id for the first problem
    @language_problem = LanguageProblem.find_first_problem_of_language(params[:language][:id])
    # then create user progress using current user and above lp id
    @user_progress = UserProgress.build_new_language_track(@language_problem, current_user)
    # save
    if @user_progress.save
      #redirect to show
      redirect_to user_progress_path
    else
      redirect_to :back
    end

  end

  def show
    # display 'verb' page
  end

  def update
  end
end
