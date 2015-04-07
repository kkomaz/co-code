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

  # Returns collection of language objects where user_progress status is 1(working on problem) or 2(completed problem)
  def user_languages
    lpids = self.user_progresses.joins(:language_problem).where('status = 1 OR status = 2').pluck(:language_problem_id)
    lids = LanguageProblem.where(:id => lpids).pluck(:language_id)
    Language.where(:id => lids)
  end

  def not_user_languages
    lpids = self.user_progresses.joins(:language_problem).where('status = 1 OR status = 2').pluck(:language_problem_id)
    lids = LanguageProblem.where(:id => lpids).pluck(:language_id)
    Language.where.not(:id => lids)
  end

  # Returns the user_progress where status = 1 (i.e. the current problem) for a given language
  # Do we want to return the language-problem itself????
  def current_problem(language)
    self.user_progresses.where(:language_problem_id => find_language_problem_ids(language)).where(:status => 1)
    # self.user_progresses.where(:language_problem_id => find_language_problem_ids(language)).where(:status => 1)[0].language_problem
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

end
