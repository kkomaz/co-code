class Lesson < ActiveRecord::Base
  belongs_to  :room
  belongs_to  :host, :class_name => "User"
  has_many  :invitations, dependent: :destroy
  has_many  :users, :through => :invitations
  
  def upcoming_lessons(user)

  end

end
