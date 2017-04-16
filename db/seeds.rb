# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
 AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')



#Contact.create(title: 'Contact Us', text: 'Hey wzp')
# create_table "products", force: :cascade do |t|
#   t.string   "name"
#   t.text     "description"
#   t.decimal  "price"
#   t.integer  "quantity"
#   t.decimal  "discount"
#   t.integer  "category_id"
# Product.create(name: "Blue Bento", description:)
#
# 15.times do
#   p = Product.new
#   p.name  = Faker::Commerce.unique.product_name
#   p.description = Faker::Commerce.department
#   p.price = Faker::Commerce.price
#   p.quantity = Faker::Number.number(2)
#   p.discount = 25
#   p.category_id = 2
#   p.save
# end
#
#
# OrderStatus.create! id: 1, status: "Pending"
# OrderStatus.create! id: 2, status: "Paid"
# OrderStatus.create! id: 3, status: "Shipped"
# OrderStatus.create! id: 4, status: "Cancelled"
#
# Province.create! name: "Manitoba", gst: 5, pst: 8, hst: 0
# Province.create! name: "Alberta", gst: 5, pst: 0, hst: 0
# Province.create! name: "British Columbia", gst: 5, pst: 7, hst: 0
# Province.create! name: "New Brunswick", gst: 0, pst: 0, hst: 15
# Province.create! name: "Newfoundland and Labrador", gst: 0, pst: 0, hst: 15
# Province.create! name: "Northwest Territories", gst: 5, pst: 0, hst: 0
# Province.create! name: "Nova Scotia", gst: 0, pst: 0, hst: 15
# Province.create! name: "Nunavut", gst: 5, pst: 0, hst: 0
# Province.create! name: "Ontario", gst: 0, pst: 0, hst: 13
# Province.create! name: "Prince Edward Island", gst: 0, pst: 0, hst: 15
# Province.create! name: "Quebec", gst: 5, pst: 9.975, hst: 0
# Province.create! name: "Saskatchewan", gst: 5, pst: 5, hst: 0
# Province.create! name: "Yukon", gst: 5, pst: 0, hst: 0

About.create! title: "Yukon", text: 'This', image: '/uploads/about/image/1/senju_brothers_by_bluejasmine155.jpg'
