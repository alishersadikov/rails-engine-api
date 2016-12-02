class InvoiceItemSerializer < ActiveModel::Serializer
  attributes :id, :invoice_id, :item_id, :quantity
  attribute :formatted_unit_price, :unit_price

  def formatted_unit_price
    sprintf "%.2f", (object.unit_price/100.00).to_s
  end
end
