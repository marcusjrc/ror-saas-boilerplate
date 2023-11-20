# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Product.create(title: 'Bronze', content: 'Basic tier', price: 1000)
Product.create(title: 'Silver', content: 'Our suggested tier', price: 1400)
Product.create(title: 'Gold', content: 'Gold tier', price: 3000)
