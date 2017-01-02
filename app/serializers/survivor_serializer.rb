class SurvivorSerializer < ActiveModel::Serializer
  attributes :id, :age, :gender, :name, :last_location_latitude, :last_location_longitude, :infected
  has_many :items
end
