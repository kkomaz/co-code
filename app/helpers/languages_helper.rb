module LanguagesHelper

  def language_icon(language)
    case language.name
    when "Ruby"
      "ruby"
    when "JavaScript"
      "javascript"
    when "Perl"
      "perl"
    when "Python"
      "python"
    when "C++"
      "cplusplus"
    when "PHP"
      "php"
    when "Haskell"
      "haskell"
    when "Java"
      "java"
    end
  end

  def language_color(language)
    case language.name
    when "Ruby"
      "#E74C3C"
    when "JavaScript"
      "#F1C40F"
    when "Perl"
      "#99CCCC"
    when "Python"
      "#4281B3"
    when "C++"
      "#CC6699"
    when "PHP"
      "#99CC66"
    when "Haskell"
      "#16A085"
    when "Java"
      "#FA954D"
    end
  end

  def language_symbol(language)
    raw("<i style='color: #{language_color(language)};' class='icon-#{language_icon(language)}'></i>")
  end

end
