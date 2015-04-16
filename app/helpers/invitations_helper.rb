module InvitationsHelper

  def lesson_link(lesson, &block)
    link_to problem_room_path(lesson.language, lesson.problem, lesson.room), role: "menuitem", tabindex: "-1", :class => "clearfix" do
      yield
    end
  end

end
