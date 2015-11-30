module ApplicationHelper
  def title(page_title)
    content_for(:title) { page_title}
  end

  def flash_class(type)
    case type
    when 'alert'
        "alert-danger"
    when 'notice'
        "alert-success"
    else
        "alert-info"
    end
  end

end
