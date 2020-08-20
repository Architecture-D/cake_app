class Customers::ProductsController < ApplicationController
  def index
  	 @genres = Genre.where(is_active: true)

     #「ジャンルのステータス有効になっている」＋「商品のステータスが販売中になっている」商品のみ表示
  	 @products = Product.joins(:genre).where(is_active: true, genres: { is_active: "true"})

  	 #products = Product.where(genre_id: params[:product][:genre_id],is_active: true)
  end

  def show
     @product = Product.find(params[:id])
  end

end