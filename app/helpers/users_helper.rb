module UsersHelper

  def disabled
    "disabled" if current_user.available_user_languages.count < 1
  end
end
