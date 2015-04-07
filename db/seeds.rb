# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

problems = ProblemScraper.new.create_import_hash
Problem.create(problems)

Language.create(:name => "Ruby")
Language.create(:name => "JavaScript")

Language.all.each do |language|
  Problem.all.each do |problem|
    language.language_problems.create(:problem => problem)
  end
end