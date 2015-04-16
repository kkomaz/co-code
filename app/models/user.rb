class User < ActiveRecord::Base
  include Concerns::Users::OnlineStatus

  before_create :generate_channel_key

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  has_many  :user_progresses
  has_many  :language_problems, :through  => 'user_progresses'
  has_many  :comments
  has_many  :posts
  has_many  :messages
  has_many  :invitations
  has_many  :courses, :through => :invitations, :source => :lesson
  has_many  :lessons, :foreign_key => "host_id"


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

  # Returns a users favorited problems for a given language
  def favorited_problems(language)
    self.user_progresses.where(:language_problem_id => find_language_problem_ids(language)).where(:favorite => true)
  end

  # Helper method to find lpids for a given language
  def find_language_problem_ids(language)
    self.language_problems.where(:language => language).pluck(:id)
  end

  # Finds and returns the next problem for a user's language
  def next_problem(language)
    self.problems_viewed_but_not_started(language).order(:language_problem_id).limit(1)
  end

  # change user's current problem based on the user_progress status
  def change_current_problem(user_progress)
    if user_progress.status == 0
      self.replace_current_problem(user_progress.language)
    elsif user_progress.status == 1
      next_language_problem = self.next_problem(user_progress.language)[0].language_problem
      UserProgress.progress_for_user(self, next_language_problem).update(:status => 1)
    end
  end

  # active invitations
  def upcoming_courses
    self.courses.where("schedule >= ?", Time.now.utc).order(:schedule)
  end

  # upcoming invitations by language
  def upcoming_courses_for_current_lang(language)
    # pending
  end

  # Get upcoming lessons where user is the host for a given language
  def upcoming_lessons(language)
    Lesson.joins(:room => {:language_problem => :language}).
    where(:languages => {:id => language}).
    where("host_id = ? AND schedule >= ?", self, Time.now)
  end

  # all other users except for the one provided
  def self.all_others(user)
    self.where.not(:id => user.id)
  end

  private
    def generate_channel_key
      begin
        key = SecureRandom.urlsafe_base64
      end while User.where(:channel_key => key).exists?
      self.channel_key = key
    end
end
