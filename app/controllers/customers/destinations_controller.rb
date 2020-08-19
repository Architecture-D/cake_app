class Customers::DestinationsController < ApplicationController
  def index
    @destination = Destinations.new
    @desitinations = Destinations.all
  end

  def create
    @destination = Destinations.new
    @destination.customer_id = current_user.id
    if @destination_new.save
      redirect_to destinations_path(@destinations_new), notice: "You have created book successfully."
    else
      @destinations = Destinations.all
      render 'index'
  end

  def destroy
  end

  def edit
  end

  def update
  end
end
