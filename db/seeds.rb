require 'faker'

# Clear existing products (optional, if you want to start fresh)
Product.destroy_all

# Array to hold products data
products_data = []

# Generate 100 random products
100.times do |i|
  products_data << {
    name: "Product #{i + 1}",
    description: Faker::Lorem.sentence,
    price: rand(10.0..100.0).round(2),
    image_url: Faker::LoremFlickr.image(size: "300x300", search_terms: ['food'])
  }
end

# Create products in bulk
Product.create!(products_data)

puts "Seeded 100 products successfully!"
