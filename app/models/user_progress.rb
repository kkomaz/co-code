class UserProgress < ActiveRecord::Base
  include Concerns::UserProgresses::ProblemStatuses

  belongs_to  :user
  belongs_to  :language_problem
  delegate :language, :to => :language_problem
  delegate :problem, :to => :language_problem

  validates :user_id, :language_problem_id, :presence => true
  validates :status, {inclusion: {in: 0..2}, numericality: {only_integer: true }}
  validates :favorite, inclusion: {in: [true,false]}

  validates_uniqueness_of :user_id, :scope => :language_problem_id

  def self.progress_for_user(user, language_problem)
    self.where({:user => user, :language_problem => language_problem}).first
  end
end
