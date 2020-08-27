class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def tax_include_price
	(price*1.08).round
  end
end
