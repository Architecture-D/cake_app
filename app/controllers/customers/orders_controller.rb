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
        @order.name = @customer.first_name
      when 2
        @sta = params[:order][:address].to_i
        @send_to_address = Destination.find(@sta)
        @order.post_code = @send_to_address.post_code
        @order.address = @send_to_address.address
        @order.name = @send_to_address.name
      when 3
        @order.post_code = params[:order][:new_add][:post_code]
        @order.address = params[:order][:new_add][:address]
        @order.name = params[:order][:new_add][:name]
    end
    #なんで最初にnewがあるん
    # render :new if @order.invalid?
  end

  def create
    @customer = Customer.find(current_customer.id)
    if current_customer.cart_items.exists?
      @order = Order.new(order_params)
      # これいる？
      @order.customer_id = current_customer.id
      # いらなかった
      # @add = params[:order][:add].to_i
      # case @add
      #   when 1
      #     p "--------------------a"
      #     @order.post_code = @customer.post_code
      #     p "--------------------b"
      #     @order.address = @customer.address
      #     p "--------------------c"
      #     #フルネームにする
      #     @order.name = @current.first_name
      #     p "--------------------d"
      #   when 2
      #     p "--------------------e"
      #     @order.post_code = params[:order][:post_code]
      #     p "--------------------f"
      #     @order.address = params[:order][:address]
      #     p "--------------------g"
      #     @order.name = params[:order][:name]
      #     p "--------------------h"
      #   when 3
      #     p "--------------------i"
      #     @order.post_code = params[:order][:post_code]
      #     p "--------------------j"
      #     @order.address = params[:order][:address]
      #     p "--------------------k"
      #     @order.name = params[:order][:name]
      #     p "--------------------l"
      # end
      p "--------------------a"
      @order.save
      p "--------------------b"
      if Destination.find_by(address: @order.address).nil?
        @address = Destination.new
        @address.post_code = @order.post_code
        @address.address = @order.address
        @address.name = @order.name
        @address.customer_id = current_customer.id
        p "--------------------c"
        @address.save
        p "--------------------d"
      end
      p "--------------------e"
      current_customer.cart_items.each do |cart_item|
        p "--------------------f"
        order_product = @order.order_products.build
        # order_product = OrderProduct.new
        # order_product.order = @order
        p "--------------------g"
        order_product.order_id = @order.id
        p @order.id

        order_product.product_id = cart_item.product_id
        p cart_item.product_id

        order_product.quantity = cart_item.quantity
        p cart_item.quantity

        order_product.purchase_price = cart_item.product.price
        p cart_item.product.price

        p "--------------------h"
        order_product.save
        p "--------------------i"
        # cart_item.destroy
      end
      render :thank
    else
      redirect_to customer_top_path
      flash[:danger] = 'カートが空です。'
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
