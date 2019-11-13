class CreatePlants < ActiveRecord::Migration[5.1]
  def change
    create_table :plants do |t|
      t.string :name
      t.string :zipcode
      t.string :address
      t.string :tel_1
      t.string :tel_2
      t.string :fax
      t.string :email
      t.string :staff_1
      t.string :staff_2
      t.string :note
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
