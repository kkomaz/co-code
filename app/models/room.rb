class Room < ActiveRecord::Base
  include Concerns::Rooms::OnlineStatus
  belongs_to :language_problem
  has_many :messages
  has_many :lessons
  delegate :language, :to => :language_problem
  delegate :problem, :to => :language_problem

  validates :title, :presence => true

  def shortened_title
    self.title.length >50 ? self.title[0..50] + "..." : self.title
  end
end
