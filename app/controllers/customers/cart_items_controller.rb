class Customers::CartItemsController < ApplicationController

before_action :authenticate_customer!

  def create
    @cart_item = current_customer.cart_items.new(cart_item_params)
    if @cart_item.product.is_active == true
      @already_cart_item = CartItem.find_by( product_id: @cart_item.product_id, customer_id: current_customer.id )
      if @already_cart_item.nil?
        @cart_item.save
      else
        #@already_cart_item.increment!(:quantity, params[:cart_item][:quantity].to_i)
        @already_cart_item.quantity += params[:cart_item][:quantity].to_i 
        @already_cart_item.save 
      end
    end
    redirect_to cart_items_path
  end

  def index
    @cart_items = current_customer.cart_items
    #@products = Product.where.not(@cart_items)
    @products = Product.joins(:cart_items).where(cart_items: {product_id: nil})
    binding.pry
    #@products = Product.joins(:genre).where(is_active: true, genres: { is_active: "true"})
  end

  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to cart_items_path
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end


  private
  def cart_item_params
    params.require(:cart_item).permit(:product_id, :quantity, :customer_id)
  end

end
