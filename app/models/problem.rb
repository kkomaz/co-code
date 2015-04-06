class Problem < ActiveRecord::Base
  has_many  :language_problems
  has_many  :languages, :through => 'language_problems'
end
