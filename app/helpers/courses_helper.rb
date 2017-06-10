module CoursesHelper
  def cents_to_dollars(cents)
    dollars = cents / 100
    return "$#{dollars}"
  end

  def sort_courses_link(text, column, direction)
    direction = direction == "DESC" ? "ASC" : "DESC"
    @buffer = ActiveSupport::SafeBuffer.new
    @buffer << link_to(text, courses_path(sort_column: column, direction: direction))
    if @sorting.column == column
      klass = direction == "DESC" ? "dropup" : "dropdown"
      @buffer << content_tag(:span, class: klass) do
        content_tag(:span, '', class: "caret");
      end
    end
    @buffer
  end
end
