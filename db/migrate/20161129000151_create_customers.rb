class CreateCustomers < ActiveRecord::Migration[5.0]
  def change
    enable_extension 'citext'

    create_table :customers do |t|
      t.citext :first_name
      t.citext :last_name

      t.timestamps
    end

    # add_index :customers, :first_name, unique: true
    # add_index :customers, :last_name, unique: true
  end
end
