class Admin::ProductsController < ApplicationController
  def index
    @products = Product.all.page(params[:page])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
     if @product.save
      redirect_to admin_product_path(@product.id), notice:"商品投稿完了しました"
     else
       render 'new'
     end
  end

  def show
    @product = Product.find(params[:id])
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to admin_product_path(@product.id), notice: "You have updated successfully."
    else
      @product = Product.find(params[:id])
      render "edit"
    end
  end

  private
  def product_params
    params.require(:product).permit(:image, :name, :introduction, :genre_id, :price, :is_active)
  end
end
