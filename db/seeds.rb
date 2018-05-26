User.create!(name:  "Example User",
             email: "ad@ad.com",
             password:              "123456",
             password_confirmation: "123456",
             admin: true)

99.times do |n|
  name  = Faker::Name.name
  email = "user#{n+1}@user.org"
  password = "123456"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end
