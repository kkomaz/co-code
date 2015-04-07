class UserProgress < ActiveRecord::Base
  belongs_to  :user
  belongs_to  :language_problem

  validates :user_id, :language_problem_id, :presence => true
  validates :status, {inclusion: {in: 0..2}, numericality: {only_integer: true }}
  validates :favorite, inclusion: {in: [true,false]}

  validates_uniqueness_of :user_id, :scope => :language_problem_id
  validates_uniqueness_of :language_problem_id, :scope => :user_id

  def self.build_user_progress(language_problem, user)
    UserProgress.new(:user => user, :language_problem => language_problem, :status => 1)
  end

end
