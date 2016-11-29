require 'csv'

require 'rake/testtask'

task :default => 'import:all'

DATA_FILES = FileList['data/*.rb']

namespace :test do
  desc "import all files"
  Rake::TestTask.new(:all) do |t|
    t.data_fiels = DATA_FILES
  end

  rule /^test:/ => lambda { |tn| "data/import_%s.rb" % tn.gsub(/^test:/,'') } do |rule|
    ruby rule.source
  end
end



namespace :import_from_csv do
  desc "import customers" do |table|
  task "import_#{table}" => :environment do
    csv_text = File.read("./data/#{table}.csv")
    csv = CSV.parse(csv_text, :headers => true)
    csv.each { |row| table.chop.capitalize.create!(row.to_hash) }
  end
  # desc "import invoice-items"
  # task import_customers: :environment do
  #   csv_text = File.read('./data/invoice-items.csv')
  #   csv = CSV.parse(csv_text, :headers => true)
  #   csv.each { |row| Customer.create!(row.to_hash) }
  # end
  # desc "import invoices"
  # task import_customers: :environment do
  #   csv_text = File.read('./data/invoices.csv')
  #   csv = CSV.parse(csv_text, :headers => true)
  #   csv.each { |row| Customer.create!(row.to_hash) }
  # end
  # desc "import  items"
  # task import_customers: :environment do
  #   csv_text = File.read('./data/items.csv')
  #   csv = CSV.parse(csv_text, :headers => true)
  #   csv.each { |row| Customer.create!(row.to_hash) }
  # end
  #
  # desc "import merchants"
  # task import_merchants: :environment do
  #   csv_text = File.read('./data/merchants.csv')
  #   csv = CSV.parse(csv_text, :headers => true)
  #   csv.each { |row| Customer.create!(row.to_hash) }
  # end
  #
  # desc "import transactions"
  # task import_transactions: :environment do
  #   csv_text = File.read('./data/transactions.csv')
  #   csv = CSV.parse(csv_text, :headers => true)
  #   csv.each { |row| Customer.create!(row.to_hash) }
  end
end
