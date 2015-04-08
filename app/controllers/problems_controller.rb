class ProblemsController < ApplicationController
  def index
  end

  def show
    @language_problem = LanguageProblem.find_language_problem(params[:language_id], params[:id])
    @language = @language_problem.language
    @problem = @language_problem.problem
    @posts = @language_problem.posts.last(5)
  end

end
