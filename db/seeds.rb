# Scrape problems from euler website
problems = ProblemScraper.new.create_import_hash
Problem.create(problems)

Language.create(:name => "Ruby")
Language.create(:name => "JavaScript")
Language.create(:name => "Python")
Language.create(:name => "Perl")
Language.create(:name => "C++")
Language.create(:name => "PHP")
Language.create(:name => "Haskell")
Language.create(:name => "Java")


# Create language_problems
Language.all.each do |language|
  Problem.all.each do |problem|
    language.language_problems.create(:problem => problem)
  end
end
