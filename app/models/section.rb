require 'securerandom'

class Section < ActiveRecord::Base
  belongs_to :course
  has_many :enrollments
  has_many :students, through: :enrollments

  # Each section should be uniquely identifiable.
  # This is not the primary key since it's a pain
  # to work with UUID as foreign key
  before_save do
    self.uuid = SecureRandom.uuid
  end

  # Use a bitmask to store meeting days
  DAYS = {
    :mon => "Monday",
    :tue => "Tuesday",
    :wed => "Wednesday",
    :thu => "Thursday",
    :fri => "Friday",
    :sat => "Saturday",
    :sun => "Sunday"
  }

  bitmask :days, as: DAYS.keys

  def enrolled?(student)
    students.exists?(student)
  end

  def to_param
    self.uuid
  end
end
