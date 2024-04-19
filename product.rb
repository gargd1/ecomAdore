class Product < ApplicationRecord
  has_one_attached :image
  has_many :product_sizes
  has_many :sizes, through: :product_sizes
  has_many :product_colors
  has_many :colors, through: :product_colors
  has_many :product_categories, dependent: :destroy
  has_many :categories, through: :product_categories
end
