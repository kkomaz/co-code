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

  def shortened_name(len=30, elip=39)
    self.title[/Problem \d+.{1,#{len}}/] + (self.title.length > elip ? '...' : '')
  end

  def self.first_problem
    self.order(:id).limit(1)[0]
  end

  def problem_digit
    self.slug.split("-").last
  end

end
