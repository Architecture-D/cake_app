class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def price_with_tax
    1000 * 1.08
  end
end
