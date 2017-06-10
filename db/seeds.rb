# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


def rand_str
  (0...8).map { (65 + rand(26)).chr }.join
end

100.times do 
  Course.create!(name: rand_str, cost: Random.rand(1000..99999),
                 description: rand_str)

end

100.times do
  Professor.create!(first_name: rand_str, last_name: rand_str, title: rand_str)
end

10000.times do 
  Section.create!(course: Course.all.sample(1).first, 
                  professor: Professor.all.sample(1).first,
                  days: Section::DAYS.keys.sample(Random.rand(1..7)), 
                  start_time: Time.now - Random.rand(0..5).hours,
                  end_time: Time.now + Random.rand(0..5).hours)

end


Student.create!(first_name: "Johne", last_name: "Doe", password: "testing123", 
                password_confirmation: "testing123", email: "test@test.com",
                username: "tester")
