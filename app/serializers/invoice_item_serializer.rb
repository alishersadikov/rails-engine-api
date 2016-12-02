class InvoiceItemSerializer < ActiveModel::Serializer
  attributes :id, :invoice_id, :item_id, :quantity, :unit_price

  def unit_price
    sprintf "%.2f", "#{(object.unit_price/100.00)}"
  end
end
