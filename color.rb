class Color < ApplicationRecord
    has_many :product_colors
    has_many :products, through: :product_colors
end
