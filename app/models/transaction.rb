class Transaction < ApplicationRecord
  validates :credit_card_number, presence: true
  validates :result, presence: true

  belongs_to :invoice

  def self.select_random_transaction
    order("RANDOM()").first(1)
  end
end
