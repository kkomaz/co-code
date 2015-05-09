class ProblemsController < ApplicationController
  autocomplete  :problem, :title

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

  def search
    @language = Language.find(params[:language_id])
    @problem = Problem.where("title LIKE ?", "%#{params[:query]}%").limit(1).first
    if @problem
      redirect_to language_problem_path(@language.slug, @problem.slug)
    else
      flash[:alert] = "Sorry, couldn't find anything - here's your current problem"
      redirect_to language_problem_path(@language.slug, current_user.current_problem(@language))
    end
  end

end
