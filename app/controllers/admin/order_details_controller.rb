class Admin::OrderDetailsController < ApplicationController


  def update
  	order_product = OrderProduct.find(params[:id])
  	if order_product.update(order_product_params)
  	  if params[:order_product][:make_status] == "製作中"
  	  	order_product.order.update(status:"製作中")
  	  end
  	  if params[:order_product][:make_status] == "製作完了"
  	  	order_product.order.update(status:"発送準備中")
  	  end
  	  # redirect_to admin_order_path(order_product)
  	  # これではorder_pathの中にorder_productのidが入ってしまう
  	  redirect_to admin_order_path(order_product.order.id)
  	else
  	  # render
  	end

  end


  private
  	def order_product_params
  	  params.require(:order_product).permit(:make_status)
  	end
end
