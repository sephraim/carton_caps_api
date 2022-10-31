class CreateReferrals < ActiveRecord::Migration[7.0]
  def change
    create_table :referrals do |t|
      t.references :referrer, null: false
      t.references :referee, null: false
      t.datetime :completed_at

      t.timestamps
    end
    add_foreign_key :referrals, :users, column: :referrer_id
    add_foreign_key :referrals, :users, column: :referee_id
  end
end
