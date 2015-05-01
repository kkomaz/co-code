module Concerns
  module Users
    module Progresses
      extend ActiveSupport::Concern

      def reset_current_problem(language)
        current_user_progress(language).update(:status => 0)
      end

      def current_problem(language)
        current_user_progress(language).problem
      end

      def get_user_progresses(language)
        self.user_progresses.
          joins(:language_problem).
          where(:language_problems => {:language_id => language})
      end

      def incomplete_user_progresses(language)
        get_user_progresses(language).where(:status => 0)
      end

      def current_user_progress(language)
        get_user_progresses(language).where(:status => 1).first
      end

      def completed_user_progresses(language)
        get_user_progresses(language).where(:status => 2)
      end

      def next_user_progress(language)
        incomplete_user_progresses(language).
          order(:language_problem_id).
          limit(1).first
      end

      def favorited_problems(language)
        get_user_progresses(language).where(:favorite => true)
      end

    end
  end
end
