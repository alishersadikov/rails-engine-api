require 'csv'

namespace :import_from_csv do
  desc "import customers"
  task import_customers: :environment do
    csv_text = File.read("./data/customers.csv")
    csv = CSV.parse(csv_text, :headers => true)
    csv.each { |row| Customer.create!(row.to_hash) }
  end

  desc "import merchants"
  task import_merchants: :environment do
    csv_text = File.read('./data/merchants.csv')
    csv = CSV.parse(csv_text, :headers => true)
    csv.each { |row| Merchant.create!(row.to_hash) }
  end

  desc "import invoices"
  task import_invoices: :environment do
    csv_text = File.read('./data/invoices.csv')
    csv = CSV.parse(csv_text, :headers => true)
    csv.each { |row| Invoice.create!(row.to_hash) }
  end

  desc "import items"
  task import_items: :environment do
    csv_text = File.read('./data/items.csv')
    csv = CSV.parse(csv_text, :headers => true)
    csv.each { |row| Item.create!(row.to_hash) }
  end

  desc "import invoice-items"
  task import_invoice_items: :environment do
    csv_text = File.read('./data/invoice_items.csv')
    csv = CSV.parse(csv_text, :headers => true)
    csv.each { |row| InvoiceItem.create!(row.to_hash) }
  end

  desc "import transactions"
  task import_transactions: :environment do
    csv_text = File.read('./data/transactions.csv')
    csv = CSV.parse(csv_text, :headers => true)
    csv.each { |row| Transaction.create!(row.to_hash) }
  end

end
