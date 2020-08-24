class Customers::ProductsController < ApplicationController

 # def index
    # @genres = Genre.where(is_active: true)

     #「ジャンルのステータス有効になっている」＋「商品のステータスが販売中になっている」商品のみ表示
     #@products = Product.joins(:genre).where(is_active: true, genres: { is_active: "true"})

     #@products = Product.where(genre_id: params[:product][:genre_id],is_active: true)


     #省略されてるけどここで　rende indexしてviewに飛ばしてる
  #end

  #def search?してジャンルID持ってきたあと↑のindexにrenderかな？

  #def index
    #if params[:genre_id].present?
      #@products = Product.where(genre_id: params[:product][:genre_id],is_active: true)

  def index
      @genres = Genre.where(is_active: true)
    if params[:genre_id].present?
      @products = Product.where(genre_id: params[:genre_id],is_active: true)
    else
      @products = Product.joins(:genre).where(is_active: true, genres: { is_active: "true"})
    end
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