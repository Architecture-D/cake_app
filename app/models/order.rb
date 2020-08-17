class Order < ApplicationRecord

    belongs_to :customer
	has_many :order_products, dependent: :destroy
	has_many :products, through: :order_products

	validates :post_code, length: {is: 7}
	validates :address, presence: true,length: { maximum: 50}
	validates :name, presence: true,length: { maximum: 30}

	enum payment_method: {'クレジットカード': 0,'銀行振込': 1}
	enum status: {'入金待ち': 0,'入金確認': 1,'製作中': 2,'発送準備中': 3,'発送済み': 4}

end