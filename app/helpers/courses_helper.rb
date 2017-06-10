module CoursesHelper
  def cents_to_dollars(cents)
    dollars = cents / 100
    return "$#{dollars}"
  end
end
