class Customers::ProductsController < ApplicationController
def index
  end

  def show

    @product = Product.find(params[:id])
    @cart = @product.cart_items.new
  end


  private
  def product_params
    params.require(:product).permit(:name,:price,:image_id, :genre_id)
  end
end