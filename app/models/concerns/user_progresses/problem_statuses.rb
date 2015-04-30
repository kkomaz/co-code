module Concerns
  module UserProgresses
    module ProblemStatuses
      extend ActiveSupport::Concern

      module ClassMethods

        def set_first_problem_as_current(user, language_id)
          problem = Problem.first_problem
          language = Language.find(language_id)
          user_progress = progresses(language,problem).where(:user => user).first
            user_progress.update(:status => 1)
        end

        def problem_users(language, problem, user, status)
          user_ids = progresses(language,problem).where(:status => status).pluck(:user_id)
          User.where(:id => user_ids)
        end

        def progresses(language, problem)
          UserProgress.joins(:language_problem).
            where(:language_problems => {:language_id => language, :problem_id => problem})
        end

      end
    end
  end
end