class Customers::OrdersController < ApplicationController
  def new
    @order = Order.new
    @customer = Customer.find(current_customer.id)
  end

  def confirm
    @customer = Customer.find(current_customer.id)
    @order = Order.new
    @cart_items = current_customer.cart_items
    @order.payment_method = params[:order][:payment_method]
    @add = params[:order][:add].to_i
    case @add
      when 1
        @order.post_code = @customer.post_code
        @order.address = @customer.address
        @order.name = @customer.full_name
      when 2
        @sta = params[:order][:address].to_i
        @destination = Destination.find(@sta)
        @order.post_code = @destination.post_code
        @order.address = @destination.address
        @order.name = @destination.name
      when 3
        @order.post_code = params[:order][:new_add][:post_code]
        @order.address = params[:order][:new_add][:address]
        @order.name = params[:order][:new_add][:name]
    end
     render :new if @order.invalid?
  end

  def create
    @customer = Customer.find(current_customer.id)
    if current_customer.cart_items.exists?
      @order = Order.new(order_params)
      @order.customer_id = current_customer.id
      @order.save
      if Destination.find_by(address: @order.address).nil?
        @address = Destination.new
        @address.post_code = @order.post_code
        @address.address = @order.address
        @address.name = @order.name
        @address.customer_id = current_customer.id
        @address.save
      end
      current_customer.cart_items.each do |cart_item|
        order_product = @order.order_products.build
        order_product.order_id = @order.id
        order_product.product_id = cart_item.product_id
        order_product.quantity = cart_item.quantity
        order_product.purchase_price = cart_item.product.price
        order_product.save
        cart_item.destroy
      end
      render :thank
    else
      redirect_to customers_path
      flash[:danger] = 'カートが空です。'
    end
  end

  def thank

  end

  def index
    @customer = Customer.find(current_customer.id)
    @orders = @customer.orders
  end

  def show
    @order = Order.find(params[:id])
    if @order.customer_id != current_customer.id
      redirect_back(fallback_location: root_path)
      flash[:alert] = "アクセスに失敗しました。"
    end
  end

  private
  def order_params
    params.require(:order).permit(
      :created_at, :post_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status,
      order_products_attributes: [:product_id, :order_id, :purchase_price, :quantity, :make_status ])
  end
end
