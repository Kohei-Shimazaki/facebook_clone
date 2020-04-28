module ApplicationHelper
  def choose_login_or_home
    if current_user.present?
      user_path(current_user.id)
    else
      new_session_path
    end
  end
end
