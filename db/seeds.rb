User.destroy_all
Category.destroy_all
Product.destroy_all
ReceiverInfo.destroy_all
Order.destroy_all
OrderDetail.destroy_all

# User
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
  password = "123456"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end

# Receiver_infos
users = User.all

receiver_infos = []
users.each do |user|
  3.times do |n|
    receiver_infos << ReceiverInfo.create!(
      user: user,
      name: Faker::Name.name,
      phone: Faker::PhoneNumber.phone_number,
      address: Faker::Address.full_address
    )
  end
end

# Category
categories = 10.times.map do |n|
  Category.create!(name: "Category-#{n + 1}")
end

# Product
products = []
100.times do |n|
  name = "Product-#{n + 1}"
  description = "This is the description for #{name}."
  price = rand(1..10) * 1000
  stock_quantity = rand(1..100)
  image = ""
  category_id = categories.sample.id

  products << Product.create!(
    name: name,
    description: description,
    price: price,
    stock_quantity: stock_quantity,
    image: image,
    category_id: category_id
  )
end

# Order
users.each do |user|
  3.times do
    order = Order.create!(
      user: user,
      receiver_info: receiver_infos.sample,
      date_place_order: Time.zone.now,
      status: ["pending", "shipping", "completed", "cancelled"].sample,
      payment_option: "Cash on Delivery"
    )

    total_price = 0

    rand(1..5).times do
      product = products.sample
      quantity = rand(1..3)

      order_detail = OrderDetail.create!(
        order: order,
        product: product,
        quantity: quantity,
        price: product.price
      )

      total_price += order_detail.price * order_detail.quantity
    end

    order.update(total_price: total_price)
  end
end
