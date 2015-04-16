class Lesson < ActiveRecord::Base
  belongs_to  :room
  belongs_to  :host, :class_name => "User"
  has_many  :invitations, dependent: :destroy
  has_many  :users, :through => :invitations
  delegate :language, to: :room
  delegate :problem, to: :room

  validates :description, :schedule, :room, :host, :presence => true


  def self.create_with_datetime(lesson_params, user)
    lesson = {:schedule => DateTime.strptime(lesson_params[:schedule], "%m/%d/%Y %I:%M %p") + lesson_params[:time_zone].to_i.hours,
              :description => lesson_params[:description],
              :host => user}
    Lesson.new(lesson)
  end


end
