class Lesson < ActiveRecord::Base
  belongs_to  :room
  belongs_to  :host, :class_name => "User"
  has_many  :invitations
  has_many  :users, :through => :invitations
  
end
