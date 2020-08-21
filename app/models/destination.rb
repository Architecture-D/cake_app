class Destination < ApplicationRecord
  belongs_to :customer

  validates :post_code, presence: true, length: { is: 7 }
  validates :address, presence: true, length: {maximum: 50}
  validates :name, presence: true, length: {maximum: 30}

  def order_address
    self.post_code + " " + self.address + " " + self.name
  end
end
