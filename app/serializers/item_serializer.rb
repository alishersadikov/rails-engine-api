class ItemSerializer < ActiveModel::Serializer
  attributes :description, :id, :merchant_id, :name, :unit_price

  def unit_price
   "#{(object.unit_price/100.00)}"
  end

end
