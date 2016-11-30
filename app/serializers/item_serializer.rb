class ItemSerializer < ActiveModel::Serializer
  attributes :description, :id, :merchant_id, :name, :unit_price

end
