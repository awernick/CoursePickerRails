module SectionsHelper
  def day_bitmask_to_str(days)
    names = days.map do |day|
      Section::DAYS[day]
    end
    
    return names.join(", ")
  end
end
