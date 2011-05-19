# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def slink_to(key_name, key_value, name, options = nil, html_options = nil)
    key_name  = "default" if key_name == nil
    key_value = controller_name() if key_value == nil
    session[key_name] = key_value
    link_to(name, options, html_options)
  end

  def fill_ajax_errors(object)
    if object.errors.any?
      @ajax_errors =object.errors
    end
  end
end
