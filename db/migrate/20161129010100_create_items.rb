class CreateItems < ActiveRecord::Migration[5.0]
  def change
    enable_extension 'citext'

    create_table :items do |t|
      t.citext :name
      t.text :description
      t.integer :unit_price
      t.references :merchant, foreign_key: true

      t.timestamps
    end

    # add_index :items, :name, unique: true
  end
end
