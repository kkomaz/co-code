class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  has_many  :user_progresses
  has_many  :language_problems, :through  => 'user_progresses'
  has_many  :comments
  has_many  :posts

  validates :first_name, :last_name, :presence => true

  def full_name
    first_name + " " + last_name
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.image_url = auth.info.image
    end
  end

  def replace_current_problem(language)
    self.user_progresses.where(:language_problem_id => find_language_problem_ids(language)).where(:status => 1)[0].update(status: 0)
  end

  # Returns collection of language objects where user_progress status is 1(working on problem) or 2(completed problem)
  def user_languages
    lpids = self.user_progresses.joins(:language_problem).where('status = 1 OR status = 2').pluck(:language_problem_id)
    lids = LanguageProblem.where(:id => lpids).pluck(:language_id)
    Language.where(:id => lids)
  end

  def available_user_languages
    lpids = self.user_progresses.joins(:language_problem).where('status = 1 OR status = 2').pluck(:language_problem_id)
    lids = LanguageProblem.where(:id => lpids).pluck(:language_id)
    Language.where.not(:id => lids)
  end

  # Returns the current problem (user_progress = 1) for a given language
  def current_problem(language)
    problem = self.user_progresses.where(:language_problem_id => find_language_problem_ids(language)).where(:status => 1)[0]
    problem.language_problem.problem if problem
  end

  # Returns all user_progresses where status = 0 (i.e. viewed but not selected as the current problem for that language)
  def problems_viewed_but_not_started(language)
    self.user_progresses.where(:language_problem_id => find_language_problem_ids(language)).where(:status => 0)
  end

  # Returns completed problems for a given language
  def completed_problems(language)
    self.user_progresses.where(:language_problem_id => find_language_problem_ids(language)).where(:status => 2)
  end

  # Helper method to find lpids for a given language
  def find_language_problem_ids(language)
    self.language_problems.where(:language => language).pluck(:id)
  end

  def next_problem(language)
    self.problems_viewed_but_not_started(language).order(:language_problem_id).limit(1)
  end

end
