class RoomsController < ApplicationController

  def new
    @language = Language.find(params[:language_id])
    @problem = current_user.current_problem(@language)
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    @language = Language.find(params[:language_id])
    @problem = Problem.find(params[:problem_id])
    @language_problem = LanguageProblem.find_language_problem(params[:language_id], params[:problem_id])
    @room.language_problem = @language_problem
    @room.host = current_user
    if @room.save
      redirect_to problem_room_path(@language, @problem, @room)
    else
      render 'new'
    end
  end

  def show
    @room = Room.find(params[:id])
  end

  def enter
    binding.pry
  end

  def leave
  end

  private
  def room_params
    params.require(:room).permit(:title)
  end
end
