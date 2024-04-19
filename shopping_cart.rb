class ShoppingCart
    def initialize(session)
      @session = session
      @session[:shopping_cart] ||= []
    end
  
    def add_product(product_id, quantity = 1, color_id = nil, size_id = nil)
      item = @session[:shopping_cart].find do |i|
        i["product_id"] == product_id && i["color_id"] == color_id && i["size_id"] == size_id
      end
      
      if item
        item["quantity"] += quantity
      else
        @session[:shopping_cart] << {
          "product_id" => product_id,
          "quantity" => quantity,
          "color_id" => color_id,
          "size_id" => size_id
        }
      end
    end
    
  
    def remove_product(product_id)
      @session[:shopping_cart].reject! { |i| i["product_id"] == product_id }
    end
  
    def products
      @session[:shopping_cart].map do |item|
        product = Product.find(item["product_id"])
        { product: product, quantity: item["quantity"] }
      end
    end
  
    def clear
      @session[:shopping_cart] = []
    end
  
    def total_price
      products.sum { |item| item[:product].price * item[:quantity] }
    end

    def update_product_quantity(product_id, quantity)
      item = @session[:shopping_cart].find { |i| i["product_id"] == product_id }
      return unless item
  
      if quantity > 0
        item["quantity"] = quantity
      else
        remove_product(product_id) 
      end
    end
  end
  