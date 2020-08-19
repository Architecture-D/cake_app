class Customers::CartItemsController < ApplicationController

  def create
    @cart_item = current_customer.cart_items.new(cart_item_params)
    @already_cart_item = CartItem.find_by( product_id: @cart_item.product_id )
    if @already_cart_item.nil?
      @cart_item.save
    else
      @cart_item.quantity += params[:cart_item][:quantity].to_i
      @already_cart_item.update(quantity: @cart_item.quantity)
    end
    redirect_to cart_items_path
  end

# def create
#     @cart_item_new = CartItem.new(cart_item_params)
#     # @cart_item = current_customer.cart_items
#     @already_cart_item = current_customer.cart_items.find_by( product_id: params[:cart_item][:product_id])
#     if @already_cart_item.present?
#       @already_cart_item.quantity += params[:cart_item][:quantity].to_i
#       @already_cart_item.update(quantity: @already_cart_item.quantity)
#       @cart_item_new = @already_cart_item
#     else
#       @cart_item_new.save
#     end
#       redirect_to cart_items_path
#   end



  def index
    @cart_items = current_customer.cart_items
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
    @cart_item.update(cart_item_path)
    redirect_to cart_items_path
  end


  private
  def cart_item_params
    params.require(:cart_item).permit(:product_id, :quantity, :customer_id)
  end
end
