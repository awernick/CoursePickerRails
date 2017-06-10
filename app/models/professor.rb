class Professor < ActiveRecord::Base
  has_many :sections

  def full_name
    "#{first_name} #{last_name}, #{title}"
  end

  def abbrev_name
    "#{first_name.first}. #{last_name}"
  end
end
