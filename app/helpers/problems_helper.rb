module ProblemsHelper

  def progress_buttons(language_problem)
    case UserProgress.progress_for_user(current_user, language_problem).status.to_i
    when 0
      render 'problems/current_button'
    when 1
      render 'problems/complete_button'
    when 2
      render 'problems/incomplete_button'
    end
  end

  def favorite_buttons(language_problem)
    if UserProgress.progress_for_user(current_user, language_problem).favorite
      render 'problems/unfavorite_button'
    else
      render 'problems/favorite_button'
    end
  end

  def problem_number(problem)
    problem.title[/Problem \d+/]
  end

  def problem_title(problem)
    problem.title.split(/Problem \d+:/).last
  end

end
