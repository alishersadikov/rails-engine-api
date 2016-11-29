require 'csv'

namespace :import_from_csv do
  desc "import data from csv files"
  task :import_customers => :environment do
    filename = './data/customers.csv'
    CSV.foreach(filename, :headers => true) do |row|
      Customer.create!(row.to_hash)
    end
  end
end
