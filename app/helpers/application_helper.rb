# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def list_of(things, opts={})
    return if things.blank?
    opts[:class] ||= ''
    opts[:class] += " list #{things.first.class.table_name}"
    returning '' do |html|
      if title = opts.delete(:title)
        tab(title)
        opts[:class] += ' tab'
        opts[:id] = title.underscore.downcase
      end
      html << content_tag(:div, render(:partial => things), opts)
    end
  end

  def tab(title, opts={})
    name = title.underscore.downcase
    content_for(:tabs) { content_tag(:a, title, opts.merge(:href => "##{name}", :class => 'tab')) }
  end
end
