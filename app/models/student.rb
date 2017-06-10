class Student < ActiveRecord::Base
  has_secure_password

  has_many :enrollments
  has_many :sections, through: :enrollments
  has_many :courses, through: :sections

  validates :password, {
    length: { minimum: 6 }
  }
end
