class UserProgress < ActiveRecord::Base
  belongs_to  :user
  belongs_to  :language_problem
  delegate :language, :to => :language_problem
  delegate :problem, :to => :language_problem

  validates :user_id, :language_problem_id, :presence => true
  validates :status, {inclusion: {in: 0..2}, numericality: {only_integer: true }}
  validates :favorite, inclusion: {in: [true,false]}

  validates_uniqueness_of :user_id, :scope => :language_problem_id

  def self.find_or_build_user_progress(language_problem, user)
    user_progress = UserProgress.find_or_create_by(:user => user, :language_problem => language_problem)
    user_progress.status = 1
    user_progress
  end

  def self.progress_for_user(user, language_problem)
    self.where({:user => user, :language_problem => language_problem})[0]
  end

  def self.set_first_problem_as_current(user, language_id)
    problem = Problem.first_problem
    language_problem = LanguageProblem.find_language_problem(language_id, problem.id)
    user_progress = self.where({:user => user, :language_problem => language_problem}).first
    user_progress.update(:status => 1)
  end

end
