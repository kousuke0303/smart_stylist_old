class CreateClients < ActiveRecord::Migration[5.1]
  def change
    create_table :clients do |t|
      t.string :name
      t.string :tel_1
      t.string :tel_2
      t.string :fax
      t.string :email
      t.string :zipcode
      t.string :address
      t.string :note
      t.string :work
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
