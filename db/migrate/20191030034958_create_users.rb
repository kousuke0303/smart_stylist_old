class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email, unique: true
      t.string :password_digest
      t.string :remember_digest
      t.string :question
      t.string :answer
      t.string :customer_id
      t.string :card_id
      t.string :subscription_id
      t.boolean :pay_status, default: false
      t.boolean :admin, default: false

      t.timestamps
    end
  end
end
