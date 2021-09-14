module OrdersHelper
	def number_to_clp(number)
		number_to_currency(number, unit: "$", separator: ".", delimiter: ".", precision: 0, format: "%u%n")
	end
end
