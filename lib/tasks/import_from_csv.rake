require 'csv'

namespace :import_from_csv do
  desc "import "
  task import_customers: :environment do
    csv_text = File.read('./data/customers.csv')
    csv = CSV.parse(csv_text, :headers => true)
    csv.each { |row| Customer.create!(row.to_hash) }
  end
end
