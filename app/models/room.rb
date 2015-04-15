class Room < ActiveRecord::Base
  include Concerns::Rooms::OnlineStatus

  belongs_to :language_problem
  has_many :messages
  delegate :language, :to => :language_problem
  delegate :problem, :to => :language_problem

  validates :title, :presence => true
end
