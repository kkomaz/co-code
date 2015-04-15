class LessonsController < ApplicationController

  def index
  end
  
  def new
    @lesson = Lesson.new
    @language = Language.find(params[:language_id])
    @problems = Problem.all
  end

  def create
    binding.pry
    @lesson = Lesson.new(lesson_params)
    @invitees = params[:user][:id]
    @language_problem = LanguageProblem.find_language_problem(params[:language_id], params[:problem_id])
    @lesson.build_room(:title => params[:lesson][:description], :language_problem => @language_problem)
    if @lesson.save
      Invitation.create_invitations(@lesson, @invitees)
      redirect_to user_progress_path(current_user)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
  end

  def delete
  end

  private
    def lesson_params
      params.require(:lesson).permit(:description, :schedule)
    end

end
