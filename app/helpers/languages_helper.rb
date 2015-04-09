module LanguagesHelper

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

end
