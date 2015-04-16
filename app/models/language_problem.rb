class LanguageProblem < ActiveRecord::Base
  belongs_to  :language
  belongs_to  :problem
  has_many  :user_progresses
  has_many  :users, :through => 'user_progresses'
  has_many  :posts
  has_many  :rooms

  validates :language_id, :problem_id, :presence => true

  def self.assign_all_problems(user, language)
    language = Language.find(language)
    self.where(:language => language).each do |language_problem|
      UserProgress.find_or_create_by(:user => user, :language_problem => language_problem)
    end
  end

  def self.assign_first_fifty_problems(user, language)
    @language_problems = self.where(:language => language).order(:id).limit(50)
    @language_problems.each do |language_problem|
      UserProgress.create(:user => user, :language_problem => language_problem)
    end
  end

  def self.find_language_problem(language, problem)
    language = Language.find(language)
    problem = problem ? Problem.find(problem) : Problem.find(1)
    self.where({:language => language, :problem => problem}).first
  end
end
