class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.string :kind
      t.date :order_date
      t.date :sales_date
      t.integer :retail
      t.integer :wage
      t.integer :cloth
      t.integer :lining
      t.integer :button
      t.integer :postage
      t.integer :other
      t.string :note
      t.integer :plant_id
      t.date :delivery
      t.references :client, foreign_key: true

      t.timestamps
    end
  end
end
