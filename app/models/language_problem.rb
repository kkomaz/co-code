class LanguageProblem < ActiveRecord::Base
  belongs_to  :language
  belongs_to  :problem
  has_many  :user_progresses
  has_many  :users, :through => 'user_progresses'
  has_many  :posts
  has_many  :rooms
  has_many  :lessons, :through => :rooms

  validates :language_id, :problem_id, :presence => true

  def self.upcoming_lessons(language, problem)
    LanguageProblem.find_language_problem(language, problem).
    lessons.
    where("schedule >= ?", Time.now.utc).order(:schedule)
  end

  def self.assign_problems(user, language, limit=nil)
    if limit
      language_problems = self.where(:language => language).order(:id).limit(limit)
    end
    language_problems ||= self.where(:language => language)

    language_problems.each do |language_problem|
      UserProgress.find_or_create_by(:user => user, :language_problem => language_problem)
    end
  end

  def self.find_language_problem(language, problem)
    language = Language.find(language)
    problem = Problem.find(problem)
    self.where({:language => language, :problem => problem}).first
  end
end
