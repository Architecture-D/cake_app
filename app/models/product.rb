class Product < ApplicationRecord

	validates :genre_id, presence: true
	validates :name, presence: true
	validates :introduction, presence: true, ength:{maximum: 300}
	validates :price, presence: true, numericality:{ only_integer: true}

	attachment :image_id

	has_many :cart_items
	has_many :customers, through: :cart_items
	has_many :order_items
	has_many :orders, through: :order_items
	belongs_to :genre

end
