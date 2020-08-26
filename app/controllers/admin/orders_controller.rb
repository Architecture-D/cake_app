class Admin::OrdersController < ApplicationController

  before_action :authenticate_admin!
  def index
  	@orders = Order.page(params[:page]).reverse_order
  end

  def show
  	@order = Order.find(params[:id])
    @product = @order.order_products
  end

  def update
  	order = Order.find(params[:id])
  	if order.update(order_params)
      if params[:order][:status] == "入金確認"
        order.order_products.update_all(make_status:"製作待ち")
      end
  	   redirect_to admin_order_path(order)
  	else
  		render "index"
  	end
  end


 private
 def order_params
 	params.require(:order).permit(:status)
 end
end
