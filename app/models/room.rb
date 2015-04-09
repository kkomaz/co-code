class Room < ActiveRecord::Base
  belongs_to :language_problem
  belongs_to :host, :class_name => "User"
  has_many :user_rooms
  has_many :users, :through => :user_rooms 
  has_many :messages
end
