class Customer < ApplicationRecord
  validates :first_name, presence: true, uniquness: {scope: :last_name}
  validates :last_name, presence: true, uniqueness: {scope: :first_name}

  has_many :invoices
  has_many :merchants, through: :invoices
end
