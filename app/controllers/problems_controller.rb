class ProblemsController < ApplicationController
  def index
  end

  def show
    @language_problem = LanguageProblem.find_language_problem(params[:language_id], params[:id])
    @language = @language_problem.language
    @problem = @language_problem.problem
    @users_working = UserProgress.problem_users(@language, @problem, current_user, 1)
    @users_finished = UserProgress.problem_users(@language, @problem, current_user, 2)
    @posts = Kaminari.paginate_array(@language_problem.posts.reverse).page(params[:page]).per(4)
    @post = Post.new
    @rooms = @language_problem.rooms.limit(3)
  end

end
