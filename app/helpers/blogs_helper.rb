module BlogsHelper
  def choose_new_or_edit
    if action_name == "new" || action_name == "create"
      confirm_blogs_path
    elsif action_name == "edit"
      blog_path
    end
  end
  def time_delta(updated_at)
    time = (Time.now - updated_at).to_i
    time_minute = 60
    time_hour = time_minute * 60
    time_day = time_hour * 24
    if time < time_minute
      return "#{time}s"
    elsif time < time_hour
      return "#{time / time_minute}m"
    elsif time < time_day
      return "#{time/ time_hour}h"
    else
      return l updated_at, format: :short
    end
  end
end
