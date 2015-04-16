class Lesson < ActiveRecord::Base
  belongs_to  :room
  belongs_to  :host, :class_name => "User"
  has_many  :invitations, dependent: :destroy
  has_many  :users, :through => :invitations
  delegate :language, to: :room
  delegate :problem, to: :room

end
