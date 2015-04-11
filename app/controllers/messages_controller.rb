class MessagesController < ApplicationController
  def create
    @message = Message.new(message_params)
    @room = Room.find(params[:room_id])
    @message.room = @room
    @message.user = current_user
    @message.save
    @path = problem_room_path(@room.language, @room.problem, @room)
  end


  private
    def message_params
      params.require(:message).permit(:content)
    end
end
