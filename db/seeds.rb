User.destroy_all
Category.destroy_all
Product.destroy_all

User.create!(name: "ADMIN",
             email: "admin@gmail.com",
             password: "123456",
             password_confirmation: "123456",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

30.times do |n|
  name = Faker::Name.name
  email = "user-#{n+1}@test.com"
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end

categories = 10.times.map do |n|
  Category.create!(name: "Category-#{n + 1}")
end

30.times do |n|
  name = "Product-#{n + 1}"
  description = "This is the description for #{name}."
  price = rand(10..1000) * 1000
  stock_quantity = rand(1..100)
  image = ""
  category_id = categories.sample.id

  Product.create!(
    name: name,
    description: description,
    price: price,
    stock_quantity: stock_quantity,
    image: image,
    category_id: category_id
  )
end
