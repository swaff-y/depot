# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#

Product.delete_all
# . . .
10.times do |i|
  Product.create(:title => Faker::Commerce.product_name,
  :description => Faker::ChuckNorris.fact,
  :image_url => Faker::Fillmurray.image(grayscale: false, width: 200, height: 200),
  :price => Faker::Commerce.price)
end

puts "10 products created"
