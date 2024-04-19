class HomeController < ApplicationController
  before_action :set_user, only: [:profile, :update_profile]
  def index
    @products = search_results(params).page(params[:page]).per(6)
  end
  

  def show
    @product = Product.find(params[:id])
    @sizes = Size.all
    @colors = Color.all
  end

  
  def search
    @products = search_results(params)
    render :index
  end

  # Controller for cart
  before_action :set_cart, only: [:add_to_cart, :remove_from_cart, :show_cart, :update_cart_item]
  before_action :initialize_cart
  def add_to_cart
    product_id = params[:id].to_i
    quantity = params[:quantity].to_i
    color_id = params[:color_id].to_i
    size_id = params[:size_id].to_i
  
    cart_item_key = "#{product_id}_#{color_id}_#{size_id}"
  
    current_item = session[:cart][cart_item_key]
  
    if current_item
      current_item['quantity'] += quantity
    else
      session[:cart][cart_item_key] = { 'quantity' => quantity, 'color_id' => color_id, 'size_id' => size_id }
    end
  
    redirect_to show_cart_path, notice: 'Product added to cart.'
  end
  
  def update_cart_item
    key = params[:id]
    new_quantity = params[:quantity].to_i
  
    if session[:cart][key]
      session[:cart][key]['quantity'] = new_quantity
      flash[:notice] = "Quantity updated."
    else
      flash[:alert] = "Item not found in cart."
    end
  
    redirect_to show_cart_path
  end
  def remove_from_cart
    Rails.logger.debug "Cart before removal: #{session[:cart].inspect}"
    session[:cart].delete(params[:id])
    Rails.logger.debug "Cart after removal: #{session[:cart].inspect}"
  
    redirect_to show_cart_path, notice: 'Item removed from cart.'
  end

  def profile
    @user = current_user
  end

  def update_profile
    if @user.update(user_params)
      redirect_to user_profile_path, notice: 'Profile updated successfully.'
    else
      render :profile
    end
  end

 private

  
 def search_results(params)
  products = Product.all
  if params[:keyword].present?
    keyword = params[:keyword].strip
    products = products.where("lower(products.name) LIKE lower(?) OR lower(products.description) LIKE lower(?)", "%#{keyword}%", "%#{keyword}%")
  end
  if params[:category_id].present?
    products = products.joins(:categories).where(categories: { id: params[:category_id] })
  end
  products
end

  def set_cart
    @cart = ShoppingCart.new(session)
  end

  def initialize_cart
   session[:cart] ||= {}
  end

  def set_user
    @user = current_user
  end


  def user_params
    params.require(:user).permit(:address, :province_id)
  end

end
