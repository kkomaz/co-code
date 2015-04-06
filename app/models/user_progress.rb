class UserProgress < ActiveRecord::Base
  belongs_to  :user
  belongs_to  :language_problem

  validates :user_id, :language_problem_id, :presence => true
end
