class CreateClients < ActiveRecord::Migration[5.1]
  def change
    create_table :clients do |t|
      t.string :name
      t.string :kana
      t.string :tel_1
      t.string :tel_2
      t.string :fax
      t.string :email
      t.string :address
      t.string :note
      t.string :work
      t.date :birth_year
      t.integer :birth_month
      t.integer :birth_day
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
