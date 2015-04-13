class Post < ActiveRecord::Base
  belongs_to  :language_problem
  delegate :language, to: :language_problem
  delegate :problem, to: :language_problem
  belongs_to  :user
  has_many  :comments, dependent: :destroy

  validates :title, :content, :language_problem_id, :user_id, :presence => true
end
