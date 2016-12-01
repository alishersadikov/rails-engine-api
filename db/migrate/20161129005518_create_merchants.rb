class CreateMerchants < ActiveRecord::Migration[5.0]
  def change
    enable_extension 'citext'

    create_table :merchants do |t|
      t.citext :name

      t.timestamps
    end

    # add_index :merchants, :name, unique: true
  end
end
