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

  def active_languages
     self.user_progresses.collect { |prog| prog.language_problem.language }
  end

end
