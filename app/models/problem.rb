class Problem < ActiveRecord::Base
  has_many  :language_problems
  has_many  :languages, :through => 'language_problems'

  extend FriendlyId
  friendly_id :name, use: :slugged

  validates :title, :content, :difficulty, :presence => true
  validates :difficulty, {inclusion: {in: 1..10}, numericality: { only_integer: true } }

  def name
    self.title[/Problem \d+/]
  end

  def self.first_problem
    self.order(:id).limit(1)[0]
  end
end
