class Merchant < ApplicationRecord
  validates :name, presence: true

  has_many :items
  has_many :invoices
  has_many :customers, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices

  def self.select_random_merchant
    order("RANDOM()").first(1)
  end

  def revenue(date = nil)
    if date == nil
      revenue = invoices.joins(:invoice_items, :transactions)
      .merge(Transaction.successful)
      .sum("invoice_items.quantity * invoice_items.unit_price")
      { revenue: revenue }
    else
      revenue = invoices.joins(:invoice_items, :transactions)
      .merge(Transaction.successful)
      .where(created_at: date)
      .sum("invoice_items.quantity * invoice_items.unit_price")
      { revenue: revenue }
    end
  end

  def self.total_revenue(date)
    revenue = Invoice.all.where(created_at: date)
    .joins(:invoice_items, :transactions)
    .merge(Transaction.successful)
    .sum("invoice_items.quantity * invoice_items.unit_price")
    { total_revenue: revenue }
  end

  def favorite_customer
    customers.joins(:transactions)
    .merge(Transaction.successful)
    .group(:id, :first_name)
    .order("count(customers.id) DESC").first
  end

  def self.top_merchants(quantity)
    joins(invoices: :invoice_items)
    .group(:id, "invoice_items.quantity")
    .order("sum(invoice_items.quantity) DESC").limit(quantity)
  end

  def self.most_revenue(quantity=1)
    joins(invoices: [:invoice_items, :transactions])
    .merge(Transaction.successful)
    .group(:id, :name)
    .order("sum(invoice_items.quantity * invoice_items.unit_price) DESC")
    .limit(quantity)
  end
end
