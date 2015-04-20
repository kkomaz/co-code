class User < ActiveRecord::Base
  include Concerns::Users::OnlineStatus
  include Concerns::Users::Languages
  include Concerns::Users::Progresses
  include Concerns::Users::Lessons

  before_create :generate_channel_key

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  has_many  :user_progresses
  has_many  :language_problems, :through  => 'user_progresses'

  has_many  :invitations
  has_many  :lessons, :foreign_key => "host_id"
  has_many  :courses, :through => :invitations, :source => :lesson

  has_many  :comments
  has_many  :posts
  has_many  :messages

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

  def change_current_problem(user_progress)
    if user_progress.status == 0 || user_progress.status == 2
      self.reset_current_problem(user_progress.language)
    elsif user_progress.status == 1
      next_language_problem = self.next_user_progress(user_progress.language).language_problem
      UserProgress.progress_for_user(self, next_language_problem).update(:status => 1)
    end
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
