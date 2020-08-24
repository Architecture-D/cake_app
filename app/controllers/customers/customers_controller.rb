class Customers::CustomersController < ApplicationController

  def show
    @customer = current_customer
  end

  def edit_info
    @customer = current_customer
  end

  def update_info
    @customer = current_customer
    if @customer.update(customer_params)
      redirect_to customers_path, notice: "You have updated successfully."
    else
      @customer = current_customer
      render "edit_info"
    end
  end

  def hide
    @customer = current_customer
  end

  def withdrawal
    @customer = current_customer
    @customer.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end

  private
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :post_code, :address, :phone_number, :email, :password, :is_deleted)
  end
end
