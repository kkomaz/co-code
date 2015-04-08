class PostsController < ApplicationController

  def index
    @language = Language.find(params[:language_id])
    @current_problem = current_user.current_problem(@language)
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def new
    @language = Language.find(params[:language_id])
    @current_problem = Problem.find(params[:problem_id])
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.language_problem = LanguageProblem.find_language_problem(params[:language_id],params[:problem_id])
    @post.user = current_user
    if @post.save
      redirect_to language_problem_path(params[:language_id],params[:problem_id])
    else
      render 'new'
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :content)
  end
end
