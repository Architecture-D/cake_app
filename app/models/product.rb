class Product < ApplicationRecord

	validates :genre_id, presence: true
	validates :name, presence: true
	validates :introduction, presence: true, length:{ maximum: 300}
	validates :price, presence: true, numericality:{ only_integer: true}

	attachment :image

	has_many :cart_items
	has_many :customers, through: :cart_items
	has_many :order_products
	has_many :orders, through: :order_items
	belongs_to :genre, optional: true

	def tax_include_price
		(price*1.08).round
	end

end
