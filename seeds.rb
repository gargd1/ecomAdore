# Admin: admin@example.com
# Password: password
# db/seeds.rb

Page.find_or_create_by(slug: 'about') do |page|
  page.title = 'About'
  page.content = 'Initial about us content.'
end

Page.find_or_create_by(slug: 'contact') do |page|
  page.title = 'Contact'
  page.content = 'Initial contact content.'
end

# ProductCategory.destroy_all
# ProductColor.destroy_all
# ProductSize.destroy_all
# Category.destroy_all
# Color.destroy_all
# Size.destroy_all
# Product.destroy_all


# categories = ["Dresses", "Shirts", "Tracksuits", "Accessories"]
# categories.each do |category|
#   Category.create!(name: category)
# end

# # Seed Colors
# colors = ["Black", "White", "Red", "Blue", "Pink"]
# colors.each do |color|
#   Color.create!(color: color)
# end

# # Seed Sizes
# sizes = ["XL", "XXL", "3XL", "4XL"]
# sizes.each do |size|
#   Size.create!(size: size)
# end

# # Seed Products
# products = [
#   { name: "Elegant Plus-Size Dress", description: "A beautiful dress designed for special occasions.", price: 59.99, image_url: "dress.jpg" },
#   { name: "Casual Chic Shirt", description: "Perfect for day-to-day wear, combining comfort and style.", price: 39.99, image_url: "shirt.jpg" },
#   { name: "Comfy Tracksuit", description: "Ideal for both workouts and relaxing at home.", price: 69.99, image_url: "tracksuit.jpg" },
#   { name: "Fashionable Accessories Set", description: "A set of accessories to complement any outfit.", price: 29.99, image_url: "accessories.jpg" },
#   { name: "Elegant Plus-Size Dress", description: "A beautiful dress designed for special occasions.", price: 59.99, image_url: "dress.jpg" },
#   { name: "Casual Chic Shirt", description: "Perfect for day-to-day wear, combining comfort and style.", price: 39.99, image_url: "shirt.jpg" },
#   { name: "Comfy Tracksuit", description: "Ideal for both workouts and relaxing at home.", price: 69.99, image_url: "tracksuit.jpg" },
#   { name: "Fashionable Accessories Set", description: "A set of accessories to complement any outfit.", price: 29.99, image_url: "accessories.jpg" }
# ]

# products.each do |product|
#   Product.create!(product)
# end

# # Seed Product-Categories, Product-Colors, and Product-Sizes
# Product.all.each do |product|
#   categories = Category.all.sample(2)
#   categories.each do |category|
#     ProductCategory.create!(product_id: product.id, category_id: category.id)
#   end
  
#   colors = Color.all.sample(2)
#   colors.each do |color|
#     ProductColor.create!(product_id: product.id, color_id: color.id)
#   end
  
#   sizes = Size.all.sample(2)
#   sizes.each do |size|
#     ProductSize.create!(product_id: product.id, size_id: size.id)
#   end
# end
