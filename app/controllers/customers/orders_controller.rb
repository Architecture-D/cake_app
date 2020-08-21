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
          #フルネームにする
          @order.name = @current.first_name
        when 2
          #なんでアドレスで持ってこれる？
          @sta = params[:order][:address].to_i
          @send_to_address = Destinations.find(@sta)
          @order.post_code = @send_to_address.post_code
          @order.address = @send_to_address.address
          @order.name = @send_to_address.name
        when 3
          #[:new_add]って何？
          @order.post_code = params[:order][:new_add][:post_code]
          @order.address = params[:order][:new_add][:address]
          @order.name = params[:order][:new_add][:name]
      end

  end

  def create
    @customer = Customer.find(current_customer.id)
    if current_customer.cart_items.exists?
      @order = Order.new(order_params)
      @order.customer_id = current_customer.id
      @add = params[:order][:add].to_i
      case @add
        when 1
          @order.post_code = @customer.post_code
          @order.address = @customer.address
          #フルネームにする
          @order.name = @current.first_name
        when 2
          @order.post_code = params[:order][:post_code]
          @order.address = params[:order][:address]
          @order.name = params[:order][:name]
        when 3
          @order.post_code = params[:order][:post_code]
          @order.address = params[:order][:address]
          @order.name = params[:order][:name]
      end
      @order.save
      if Address.find_by(address: @order.address).nill?
        @address = Address.new
        @address.post_code = @order.post_code
        @address.address = @order.address
        @address.name = @order.name
        @address.customer_id = current_customer.id
        @address.save
      end
    end
  end

  def thank
  end

  def index
  end

  def show
  end

  private
  def order_params
    params.require(:order).permit(
      :created_at, :post_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status,
      order_products_attributes: [:product_id, :order_id, :purchase_price, :quantity, :make_status ])
  end
end
