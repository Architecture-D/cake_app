class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :last_name, presence: true, length: {minimum: 1, maximum: 15}
  validates :first_name, presence: true, length: {minimum: 1, maximum: 15}
  validates :last_name_kana, presence: true, length: {minimum: 1, maximum: 15}
  validates :first_name_kana, presence: true, length: {minimum: 1, maximum: 15}
  validates :post_code, presence: true, length: { is: 7 }
  validates :address, presence: true,length: {minimum: 5,maximum: 50}
  validates :phone_number, presence: true,length: {minimum: 3,maximum: 15}

  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items
  has_many :orders, dependent: :destroy
  has_many :destinations, dependent: :destroy
end
