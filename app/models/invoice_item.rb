class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice

  def self.select_random_invoice_item
    order("RANDOM()").first(1)
  end
end
