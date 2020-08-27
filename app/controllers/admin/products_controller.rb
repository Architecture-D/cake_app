class Admin::ProductsController < ApplicationController
  before_action :authenticate_admin!
  before_action :product_id, only: [:show, :edit, :update]
  
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
  end

  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to admin_product_path(@product.id), notice: "商品編集完了しました"
    else
      @product = Product.find(params[:id])
      render "edit"
    end
  end

  private
  def product_params
    params.require(:product).permit(:image, :name, :introduction, :genre_id, :price, :is_active)
  end

  def product_id
    @product = Product.find(params[:id])
  end
end
