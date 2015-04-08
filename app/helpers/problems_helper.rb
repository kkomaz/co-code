module ProblemsHelper

  def progress_buttons(language_problem)
    case UserProgress.progress_for_user(current_user, language_problem).status.to_i
    when 0
      render 'problems/current_button'
    when 1
      render 'problems/complete_button'
    when 2

    end
  end

end
