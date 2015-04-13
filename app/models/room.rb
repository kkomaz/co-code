class Room < ActiveRecord::Base
  include Concerns::Rooms::OnlineStatus

  belongs_to :language_problem
  belongs_to :host, :class_name => "User"
  has_many :user_rooms
  has_many :users, :through => :user_rooms
  has_many :messages
  delegate :language, :to => :language_problem
  delegate :problem, :to => :language_problem
end
