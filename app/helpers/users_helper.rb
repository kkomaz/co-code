module UsersHelper

  def disabled
    "disabled" if current_user.available_user_languages.count < 1
  end

  def language_icon(language)
    case language.name
    when "Ruby"
      "ruby"
    when "JavaScript"
      "javascript"
    end
  end

  def language_color(language)
    case language.name
    when "Ruby"
      "#E74C3C"
    when "JavaScript"
      "#F1C40F"
    end
  end

  def language_completion(language)
    completed = completed_count(language).to_f
    total = total_count(language).to_f
    (completed / total * 100)
  end

  def completed_count(language)
    current_user.completed_problems(language).count
  end

  def total_count(language)
    LanguageProblem.where(:language => language).count
  end
end
