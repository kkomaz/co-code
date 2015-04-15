class Lesson < ActiveRecord::Base
  belongs_to  :room
  belongs_to  :host, :class_name => "User"
  has_many  :invitations
  
end
