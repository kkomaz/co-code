class Post < ActiveRecord::Base
  belongs_to  :language_problem
  belongs_to  :user
  has_many  :comments
  
end
