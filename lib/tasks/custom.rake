namespace :my_tasks do

  desc 'Add missing problems(user_progresses)'
  task :add_problems => :environment do
    User.all.each do |user|
      user.user_languages.each do |language|
        LanguageProblem.assign_all_problems(user, language)
      end
    end
  end

end
