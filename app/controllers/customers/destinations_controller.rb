class Customers::DestinationsController < ApplicationController

before_action :authenticate_customer!

  def index
    @destination = Destination.new
    @destinations = Destination.where(customer_id: current_customer.id)
  end

  def create
    @destination = Destination.new(destination_params)
    @destination.customer_id = current_customer.id
    if @destination.save
      redirect_to destinations_path
    else
      @destinations = Destination.all
      render 'index'
    end
  end

  def destroy
    @destination = Destination.find(params[:id])
    @destination.customer_id = current_customer.id
    @destination.destroy
    redirect_to destinations_path(@destination.id)
  end

  def edit
    @destination = Destination.find(params[:id])
    @destination.customer_id = current_customer.id
  end

  def update
    @destination = Destination.find(params[:id])
    if @destination.update(destination_params)
      redirect_to destinations_path
    else
      render "edit"
    end
  end

  private

  def destination_params
    params.require(:destination).permit(:post_code, :address, :name)
  end

end
