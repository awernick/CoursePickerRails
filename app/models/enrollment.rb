class Enrollment < ActiveRecord::Base
  has_many :users
  has_many :sections
end
