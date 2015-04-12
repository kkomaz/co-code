class ProblemsController < ApplicationController
  def index
  end

  def show
    @language_problem = LanguageProblem.find_language_problem(params[:language_id], params[:id])
    @language = @language_problem.language
    @problem = @language_problem.problem
    @users_working = UserProgress.current_problem_users(@language, @problem, current_user)
    @users_finished = UserProgress.finished_problem_users(@language, @problem, current_user)
    @posts = Kaminari.paginate_array(@language_problem.posts.reverse).page(params[:page]).per(3)
    @post = Post.new
    @rooms = @language_problem.rooms.limit(3)
  end

end
