require 'active_support'

module SectionsHelper
  def day_bitmask_to_str(days)
    names = days.map do |day|
      Section::DAYS[day]
    end
    
    return names.join(", ")
  end

  def sort_link(text, column, direction)
    direction = direction == "DESC" ? "ASC" : "DESC"
    @buffer = ActiveSupport::SafeBuffer.new
    @buffer << link_to(text, course_sections_path(sort_column: column, direction: direction))
    if @sorting.column == column
      klass = direction == "DESC" ? "dropup" : "dropdown"
      @buffer << content_tag(:span, class: klass) do
        content_tag(:span, '', class: "caret");
      end
    end
    @buffer
  end
end
