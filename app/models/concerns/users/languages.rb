module Concerns
  module Users
    module Languages
      extend ActiveSupport::Concern

      def user_languages
        Language.where(:id => get_language_ids)
      end

      def available_user_languages
        Language.where.not(:id => get_language_ids)
      end

      def get_language_ids
        lpids = self.user_progresses.joins(:language_problem).
        where('status = 1 OR status = 2').pluck(:language_problem_id)

        LanguageProblem.where(:id => lpids).pluck(:language_id)
      end

    end
  end
end
