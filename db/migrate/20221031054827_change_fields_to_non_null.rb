class ChangeFieldsToNonNull < ActiveRecord::Migration[7.0]
  def change
    change_column_null :users, :first_name, false
    change_column_null :users, :last_name, false
    change_column_null :users, :birthdate, false
    change_column_null :users, :zip_code, false
    change_column_null :users, :referral_code, false
    change_column_null :referrals, :completed_at, false
  end
end
