class Item < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true

  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.select_random_item
    order("RANDOM()").first(1)
  end

  def best_day
    invoices.joins(:invoice_items, :transactions)
    .merge(Transaction.successful)
    .group(:id)
    .order("count(invoice_items.quantity) DESC", "created_at DESC")
    .first.created_at
  end

  def self.most_revenue(quantity = 1)
    joins(invoices: [:invoice_items, :transactions])
    .merge(Transaction.successful)
    .group(:id, :name)
    .order("sum(invoice_items.quantity * invoice_items.unit_price) DESC")
    .limit(quantity)
  end

  def self.most_items(quantity = 1)
    joins(invoices: [:invoice_items, :transactions])
    .merge(Transaction.successful)
    .group(:id, :name)
    .order("count(invoice_items.quantity) DESC")
    .limit(quantity)
  end

  def self.format_unit_price(params)
    params[:unit_price] = (params[:unit_price].gsub!(/^\"|\"?$/, '').to_f*100).round
  end
end
