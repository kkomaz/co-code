class Language < ActiveRecord::Base
  has_many :language_problems
  has_many :problems, :through => 'language_problems'
end
