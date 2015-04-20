module InvitationsHelper

  def lesson_link(lesson, &block)
    link_to problem_room_path(lesson.language, lesson.problem, lesson.room), role: "menuitem", tabindex: "-1", :class => "clearfix" do
      yield
    end
  end

  def display_language_problem_lessons(language, problem)
     display_upcoming_lessons(next_language_problem_lessons(language, problem))
  end

  #create method to actually display the count
  def show_count(collection)
    if !collection.empty?
      count = collection.count
      render 'layouts/notification_count', :count => count if count > 0
    end
  end

  #create method to get collection for users invite
  def users_courses
    current_user.all_upcoming_courses.limit(5)
  end

  #create method to get collection for language problem lessons
  def next_language_problem_lessons(language, problem)
    LanguageProblem.upcoming_lessons(language, problem).limit(5)
  end

  #create method to actually display the collection
  def display_upcoming_lessons(collection)
    render partial: 'layouts/notification', collection: collection, as: :lesson
  end

end
