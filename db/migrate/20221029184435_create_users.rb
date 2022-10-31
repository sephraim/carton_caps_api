class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.date :birthdate, null: false
      t.integer :zip_code, null: false
      t.string :referral_code, null: false, index: { unique: true }

      t.timestamps
    end
  end
end
