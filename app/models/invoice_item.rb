class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice

  def self.select_random_invoice_item
    order("RANDOM()").first(1)
  end

  def self.format_unit_price(params)
    params[:unit_price] = (params[:unit_price].gsub!(/^\"|\"?$/, '').to_f*100).round
  end
end
