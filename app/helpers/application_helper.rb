module ApplicationHelper
  def bootstrap_class_for(flash_type)
    {success: "alert-success", error: "alert-danger", alert: "alert-warning", notice: "alert-info"}.stringify_keys[flash_type.to_s] || flash_type.to_s
  end
  
  def flash_messages(opts = {})
    # js = flash.delete(:js)
    if flash.keys.without(:js).any?
      concat '<div class="flash_messages">'.html_safe
    end
    flash.each do |msg_type, message|
      next if message.blank?
      next if msg_type.to_sym == :js
      concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)} fade show flash-alert") do
        concat content_tag(:button, '&times;'.html_safe, class: "close", data: {dismiss: 'alert'})
        concat message.html_safe
      end)
    end
    if flash.keys.without(:js).any?
      concat '</div>'.html_safe
    end
    nil
  end
  
  def bootstrap_class_for_flash(flash_type)
    case flash_type
    when 'success'
      'alert-success'
    when 'error'
      'alert-danger'
    when 'alert'
      'alert-warning'
    when 'notice'
      'alert-info'
    else
      flash_type.to_s
    end
  end
end
