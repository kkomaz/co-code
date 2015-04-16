class LessonsController < ApplicationController

  def index
  end

  def new
    @lesson = Lesson.new
    @language = Language.find(params[:language_id])
    @problems = Problem.all
  end

  def create
    @lesson = Lesson.create_with_datetime(lesson_params, current_user)
    @invitees = params[:user][:id]
    @language_problem = LanguageProblem.find_language_problem(params[:language_id], params[:problem][:id])
    @lesson.build_room(:title => @lesson.description, :language_problem => @language_problem)
    if @lesson.save
      Invitation.create_invitations(@lesson, @invitees)
      redirect_to progress_path(@lesson.language.slug)
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
      params.require(:lesson).permit(:description, :schedule, :time_zone)
    end

end
