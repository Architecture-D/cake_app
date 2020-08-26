class Admin::OrderProductsController < ApplicationController

  before_action :authenticate_admin!

  def update
    order_product = OrderProduct.find(params[:id])
    if order_product.update(order_product_params)
      o = order_product.order.order_products.pluck(:make_status)
      if params[:order_product][:make_status] == "製作中"
        order_product.order.update(status:"製作中")
      elsif o.all?{|a| a == "製作完了" }
        order_product.order.update(status:"発送準備中")
      end
     redirect_to admin_order_path(order_product.order.id)
    end
  end



  private
  	def order_product_params
  	  params.require(:order_product).permit(:make_status)
  	end
end
