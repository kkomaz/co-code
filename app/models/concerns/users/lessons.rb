module Concerns
  module Users
    module Lessons
      extend ActiveSupport::Concern

      def all_upcoming_courses
        self.courses.
        where("schedule >= ?", Time.now.utc).
        order(:schedule)
      end

      def upcoming_courses(language)
        self.courses.
        joins(:room => {:language_problem => :language}).
        where(:languages => {:id => language}).
        where("schedule >= ?", Time.now)
      end

      def upcoming_lessons(language)
        self.lessons.
        joins(:room => {:language_problem => :language}).
        where(:languages => {:id => language}).
        where("schedule >= ?", Time.now)
      end

    end
  end
end
