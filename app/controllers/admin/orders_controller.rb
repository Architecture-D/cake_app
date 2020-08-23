class Admin::OrdersController < ApplicationController
  def index
  	@orders = Order.all
  end

  def show
  	@order = Order.find(params[:id])
  	@items = @order.order_products
  end

  def update
  	@order =Order.find(params[:id])
  	if @order.update(order_params)
  	   redirect_to admin_order_path(@order)
  	else
  		render "index"
  	end

  end


 private
 def order_params
 	params.require(:order).permit(:status)
 end
end
