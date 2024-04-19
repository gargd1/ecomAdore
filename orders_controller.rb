class OrdersController < ApplicationController
    before_action :initialize_cart, only: [:create] 
    
      def summary
        @user = current_user 
        @cart_items = session[:cart].map do |key, item|
          product = Product.find(key.split('_')[0].to_i)
          {
            product: product,
            quantity: item['quantity'],
            color: Color.find(item['color_id']),
            size: Size.find(item['size_id']),
            subtotal: product.price * item['quantity']
          }
        end
        @subtotal = @cart_items.sum { |item| item[:subtotal] }
        @province = Province.find(@user.province_id)
      end
  
      def index
         @orders = current_user.orders.includes(:order_items, :province).order(created_at: :desc)
      end
  
  
      def create
  
        invalid_products = []
        valid_items = []
      
        session[:cart].each do |key, item|
          product_id = key.split('_').first.to_i 
          product = Product.find_by(id: product_id)
          if product
            valid_items << { product: product, quantity: item['quantity'] }
          else
            invalid_products << key
          end
        end
      
        # Handle invalid products before attempting to save any part of the order
        unless invalid_products.empty?
          invalid_products.each { |ip| session[:cart].delete(ip) }
          redirect_to order_summary_path, alert: 'Some products in your cart could not be found and were removed. Please review your cart and try again.'
          return
        end
      
        ActiveRecord::Base.transaction do
          current_user.update(
           address: order_params[:address],
           province_id: order_params[:province_id]
          )
          @order = current_user.orders.build(order_params)
          if @order.save
            valid_items.each do |item|
              @order.order_items.create!(product: item[:product], quantity: item[:quantity])
            end
            session[:cart] = {}  # Clear the cart if all items were processed successfully
            redirect_to order_summary_path, notice: 'Order was successfully placed.'
          else
            redirect_to order_summary_path, alert: 'There was an issue placing your order.'
          end
        rescue ActiveRecord::RecordInvalid => e
          redirect_to order_summary_path, alert: "An error occurred: #{e.message}"
        end
      end
      
      private
    
      def order_params
        params.require(:order).permit(:address, :province_id, :subtotal, :gst, :pst, :hst, :total)
      end
  
      def initialize_cart
        session[:cart] ||= {}
      end
  
  end
    