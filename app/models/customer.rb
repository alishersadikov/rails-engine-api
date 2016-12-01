class Customer < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true

  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :merchants, through: :invoices

  def self.select_random_customer
    order("RANDOM()").first(1)
  end

  def favorite_merchant
    merchants.joins(:transactions)
    .merge(Transaction.successful)
    .group(:id, :name)
    .order("count(transactions) DESC").first
  end
end
