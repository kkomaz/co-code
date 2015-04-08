class UserProgress < ActiveRecord::Base
  belongs_to  :user
  belongs_to  :language_problem

  validates :user_id, :language_problem_id, :presence => true
  validates :status, {inclusion: {in: 0..2}, numericality: {only_integer: true }}
  validates :favorite, inclusion: {in: [true,false]}

  validates_uniqueness_of :user_id, :scope => :language_problem_id
  validates_uniqueness_of :language_problem_id, :scope => :user_id

  def self.find_or_build_user_progress(language_problem, user)
    user_progress = UserProgress.find_or_create_by(:user => user, :language_problem => language_problem)
    user_progress.status = 1
    user_progress
  end

end
