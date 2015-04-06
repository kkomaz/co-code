class UserProgress < ActiveRecord::Base
  belongs_to  :user
  belongs_to  :language_problem
end
