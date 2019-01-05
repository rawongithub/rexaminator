class PaginationListLinkRenderer < WillPaginate::ViewHelpers::LinkRenderer

  protected

  def page_number(page)
    unless page == current_page
      tag(:li, link(page, "?question=#{page.to_s}", :rel => rel_value(page)), :class => @options[:params][:aasm_links][page], :title => @options[:params][:aasm_links][page])
    else
      tag(:li, page, :class => "current", :title => "current")
    end
  end

  def previous_or_next_page(page, text, classname)
    if page
      tag(:li, link(text, page.to_s), :class => classname)
    else
      tag(:li, text, :class => classname + ' disabled')
    end
    nil
  end

  def html_container(html)
    tag(:ul, html, container_attributes)
  end

end
