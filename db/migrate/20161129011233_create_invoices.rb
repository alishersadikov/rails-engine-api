class CreateInvoices < ActiveRecord::Migration[5.0]
  def change
    enable_extension 'citext'

    create_table :invoices do |t|
      t.references :customer, foreign_key: true
      t.references :merchant, foreign_key: true
      t.citext :status

      t.timestamps
    end

    # add_index :invoices, :status, unique: true
  end
end
