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

bronze_title = 'Bronze'
silver_title = 'Silver'
gold_title = 'Gold'

Product.create(title: bronze_title, content: 'Basic tier', price: 1000) unless Product.find_by(title: bronze_title).exists?
Product.create(title: silver_title, content: 'Our suggested tier', price: 1400) unless Product.find_by(title: silver_title).exists?
Product.create(title: gold_title, content: 'Gold tier', price: 3000) unless Product.find_by(title: gold_title).exists?
