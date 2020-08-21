class Customers::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def confirm
    @order = Order.new(order_params)
  end

  def create
  end

  def thank
  end

  def index
  end

  def show
  end

  private
  def order_params
    params.require(:order).permit(:)
  end
end
