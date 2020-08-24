module ApplicationHelper

	def addTax(price)
		tax_price = (price*1.1).round
	end

	def totalPrice(price,quantiry)
		total_price= price*quantity
	end
end
