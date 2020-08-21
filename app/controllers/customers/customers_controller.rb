class Customers::CustomersController < ApplicationController

  def show
    @customer = current_customer
  end

  def edit_info
    @customer = current_customer
    if current_customer != @customer
      redirect_to customer_path
    end
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      redirect_to customers_path, notice: "You have updated successfully."
    else
      @customer = current_customer
      render "edit_info"
    end
  end

  def hide
  end

  def delete
    @customer = current_costomer
    @customer.destroy
    redirect_to root_path
  end

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :post_code, :adress, :phone_number, :email, :password, :is_deleted)
  end
end
