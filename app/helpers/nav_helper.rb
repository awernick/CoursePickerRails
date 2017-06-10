module NavHelper
  def nav_link_to(text, href)
    opts = {}
    if current_page? href
      opts[:class] = "active"
    end

    content_tag(:li, opts) do
      link_to(text, href)
    end
  end
end
