class UserProgress < ActiveRecord::Base
  belongs_to  :user
  belongs_to  :language_problem

  validates :user_id, :language_problem_id, :presence => true
  validates :status, {inclusion: {in: 0..2}, numericality: {only_integer: true }}
  validates :favorite, inclusion: {in: [true,false]}
end
