class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.date :birthdate
      t.integer :zip_code
      t.string :referral_code

      t.timestamps
    end
  end
end
