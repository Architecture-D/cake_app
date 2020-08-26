class Customers::HomeController < ApplicationController
  def top
  	@products = Product.joins(:genre).where(is_active: true, genres: { is_active: "true"})
  	 @genres = Genre.where(is_active: true)
  end

  def about
  end
end
