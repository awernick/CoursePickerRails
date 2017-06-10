class Course < ActiveRecord::Base
  has_many :sections
  has_many :users, through: :sections
end
