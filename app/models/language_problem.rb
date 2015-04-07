class LanguageProblem < ActiveRecord::Base
  belongs_to  :language
  belongs_to  :problem
  has_many  :user_progresses
  has_many  :users, :through => 'user_progresses'

  validates :language_id, :problem_id, :presence => true

  def self.find_language_problem(language_id, problem_id = 1)
    self.where("language_id = ? AND problem_id = ?", language_id, problem_id).first
  end
end
