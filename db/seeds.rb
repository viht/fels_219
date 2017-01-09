User.create!(name: "Admin",
  email: "admin@gmail.com",
  password: "123456",
  password_confirmation: "123456",
  role: 1)
User.create!(name: "Test",
  email: "test@gmail.com",
  password: "123456",
  password_confirmation: "123456")

99.times do |n|
  name = Faker::Name.name
  email = "trainee-#{n+1}@gmail.com"
  password = "123456"
  password_confirmation = "123456"
  User.create!(name: name, email: email, password: password,
    password_confirmation: password, role: 0)
end
