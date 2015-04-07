class Language < ActiveRecord::Base
  has_many :language_problems
  has_many :problems, :through => 'language_problems'

  extend FriendlyId
  friendly_id :name, use: :slugged

  validates :name, {:presence => true, :uniqueness => {case_sensitive: false}}
end
