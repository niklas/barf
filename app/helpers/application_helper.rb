# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def list_of(things, opts={})
    return if things.blank?
    opts[:class] ||= ''
    opts[:class] += " list #{things.first.class.table_name}"
    content_tag(:div, render(:partial => things), opts)
  end
end
