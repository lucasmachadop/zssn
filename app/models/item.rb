class Item < ApplicationRecord


	belongs_to :resource
	belongs_to :survivor


	def self.factory (type,survivor,quantity)
		Item.new(survivor:survivor,quantity:quantity,resource:Resource.find_by(name:type))
	end

end
