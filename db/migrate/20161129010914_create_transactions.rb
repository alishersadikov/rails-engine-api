class CreateTransactions < ActiveRecord::Migration[5.0]
  def change
    enable_extension 'citext'

    create_table :transactions do |t|
      t.string :credit_card_number
      t.string :credit_card_expiration_date
      t.citext :result

      t.timestamps
    end

    # add_index :transactions, :credit_card_number, unique: true
    # add_index :transactions, :credit_card_expiration_date, unique: true
    # add_index :transactions, :result, unique: true
  end
end
