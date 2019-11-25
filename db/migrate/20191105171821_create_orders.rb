class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.string :kind
      t.date :order_date
      t.date :sales_date
      t.string :retail
      t.integer :wage
      t.integer :cloth
      t.integer :lining
      t.integer :button
      t.integer :postage
      t.integer :other
      t.boolean :wage_pay, default: false
      t.boolean :cloth_pay, default: false
      t.boolean :lining_pay, default: false
      t.boolean :button_pay, default: false
      t.boolean :postage_pay, default: false
      t.boolean :other_pay, default: false
      t.boolean :unpaid, default: false
      t.string :note
      t.integer :plant_id
      t.integer :user_id
      t.date :delivery
      t.string :narrow
      t.string :img_1
      t.string :img_2
      t.string :img_3
      t.string :img_4
      t.string :img_5
      t.string :img_6
      t.string :img_7
      t.string :img_8
      t.string :img_1_note
      t.string :img_2_note
      t.string :img_3_note
      t.string :img_4_note
      t.string :img_5_note
      t.string :img_6_note
      t.string :img_7_note
      t.string :img_8_note
      t.boolean :del_img_1_check, default: false
      t.boolean :del_img_2_check, default: false
      t.boolean :del_img_3_check, default: false
      t.boolean :del_img_4_check, default: false
      t.boolean :del_img_5_check, default: false
      t.boolean :del_img_6_check, default: false
      t.boolean :del_img_7_check, default: false
      t.boolean :del_img_8_check, default: false
      t.references :client, foreign_key: true

      t.timestamps
    end
  end
end
