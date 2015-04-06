class Problem < ActiveRecord::Base
  has_many  :language_problems
  has_many  :languages, :through => 'language_problems'

  validates :title, :content, :difficulty, :presence => true
  validates :difficulty, {inclusion: {in: 1..10}, numericality: { only_integer: true } }

end
