class LanguageProblem < ActiveRecord::Base
  belongs_to  :language
  belongs_to  :problem
  has_many  :user_progresses
  has_many  :users, :through => 'user_progresses'

  validates :language_id, :problem_id, :presence => true

  def self.find_language_problem(language, problem)
    language = Language.find(language)
    problem = problem ? Problem.find(problem) : Problem.find(1)
    self.where({:language => language, :problem => problem}).first
  end
end
