class SalesController < ApplicationController
    def on_sale
        @products = Product.where(sale: true)
    end
    def new_products
        @products = Product.where('created_at >= ?', 3.days.ago)
    end
end
