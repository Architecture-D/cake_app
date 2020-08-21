class Customers::HomeController < ApplicationController
  def top
  	@products = Product.all
  end

  def about
  end
end
