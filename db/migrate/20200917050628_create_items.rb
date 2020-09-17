class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :goods,                 null: false
      t.text :details,                 null: false
      t.integer :category,             null: false
      t.integer :status,               null: false
      t.integer :shipping_fee_burden,  null: false
      t.integer :shipping_area,        null: false
      t.integer :days_to_ship,         null: false
      t.integer :price,                null: false
      t.references :user,              null: false, foreign_key: true
      t.timestamps
    end
  end
end
