class UserProgressesController < ApplicationController
  def create
    @language = Language.find(params[:language][:id])
    LanguageProblem.assign_problems(current_user, @language, 50)
    UserProgress.set_first_problem_as_current(current_user, @language)
    redirect_to user_path(current_user)
  end

  def show
    @language = Language.find(params[:id])
    @current_problem = current_user.current_problem(@language)
    @favorites = current_user.favorited_problems(@language).limit(12).order(:id)
    @lessons = current_user.upcoming_lessons(@language).order(:schedule)
    @courses = current_user.upcoming_courses(@language).order(:schedule)
  end

  def search
    @language = Language.find(params[:language_id])
    @problem = Problem.where("title LIKE ?", "%#{params[:query]}%").limit(1).first
    redirect_to language_problem_path(@language.slug, @problem.slug)
  end

  def update
    @language_problem = LanguageProblem.find_language_problem(params[:language][:id], params[:id])
    @language = @language_problem.language
    @problem = @language_problem.problem
    @user_progress = UserProgress.progress_for_user(current_user, @language_problem)
    if params[:user_progress][:status]
      current_user.change_current_problem(@user_progress)
    end
    @user_progress.update(user_progress_params)

    if params[:user_progress][:status] == "2"
      flash[:success] = "Nice job! Here's the next problem."
    end
    respond_to do |f|
      f.js {}
      f.html{redirect_to language_problem_path(@language, current_user.current_problem(@language))}
    end
  end

  private
    def user_progress_params
      params.require(:user_progress).permit(:status, :favorite)
    end

end
