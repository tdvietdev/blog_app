User.create!(name:  "Example User",
             email: "ad@ad.com",
             password:              "123456",
             password_confirmation: "123456",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

99.times do |n|
  name  = Faker::Name.name
  email = "user#{n+1}@user.org"
  password = "123456"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end

users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(80)
  title = Faker::Lorem.sentence(3)
  active = true
  users.each { |user| user.entries.create!(title: title, content: content, active: active) }

end

users = User.all
entry = Entry.all[1..30]

user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

rd = Random.new

users.each {|user| user.like entry[rd.rand(1..30)]}