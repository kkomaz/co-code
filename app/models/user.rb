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

  # Returns collection of language objects (we use language.name in the view) - GIVES back ALL languages (including user_progress = 0)
  def user_languages
    lids = self.language_problems.pluck(:language_id)
    Language.where(:id => lids)
  end

  def problems_viewed_but_not_started(language)
    self.user_progresses.where(:language_problem_id => find_language_problem_ids(language)).where(:status => 0)
  end

  def problems_in_progress(language)
    self.user_progresses.where(:language_problem_id => find_language_problem_ids(language)).where(:status => 1)
  end

  # MIGHT BE WORKING - TESTING REQUIRED
  def completed_problems(language)
    self.user_progresses.where(:language_problem_id => find_language_problem_ids(language)).where(:status => 2)
  end

  # MIGHT BE WORKING - TESTING REQUIRED
  def find_language_problem_ids(language)
    self.language_problems.where(:language => language).pluck(:id)
  end

end
