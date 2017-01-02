class ItemSerializer < ActiveModel::Serializer
  	attributes :quantity
  	belongs_to :resource
	belongs_to :survivor
end
