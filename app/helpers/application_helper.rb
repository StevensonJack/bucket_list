module ApplicationHelper
  def activity_price_color(activity)
    if activity.rating <= 1
      return "green"
    elsif activity.rating > 1 && activity.rating < 1.1
      return "orange"
    else
      return "red"
    end
  end
end
