User.create!(name: "Sample User",
             email: "sample@email.com",
             password: "password",
             password_confirmation: "password",
             admin: true)

Plant.create!(name: "test_plant1",
              tel_1: "0725654478",
              user_id: 1)
              
Plant.create!(name: "test_plant2",
              tel_1: "0725654447",
              user_id: 1)

60.times do |n|
  name  = Faker::Name.name
  email = "sample-#{n+1}@email.com"
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password)
end

60.times do |n|
  name  = Faker::Name.name
  user_id = "1"
  Client.create!(name: name,
                 user_id: user_id)
end