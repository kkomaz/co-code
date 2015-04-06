class LanguageProblem < ActiveRecord::Base
  belongs_to  :language
  belongs_to  :problem
  has_many  :user_progresses
  has_many  :users, :through => 'user_progresses'

  validates :language_id, :problem_id, :presence => true
end
