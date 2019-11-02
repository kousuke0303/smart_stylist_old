class CreatePlants < ActiveRecord::Migration[5.1]
  def change
    create_table :plants do |t|
      t.string :name
      t.string :address
      t.integer :tel_1
      t.integer :tel_2
      t.integer :fax
      t.string :email
      t.string :staff_1
      t.string :staff_2
      t.string :note
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
