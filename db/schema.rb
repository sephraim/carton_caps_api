# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 20_221_031_052_703) do
  create_table 'referrals', charset: 'utf8mb4', collation: 'utf8mb4_0900_ai_ci', force: :cascade do |t|
    t.bigint 'referrer_id', null: false
    t.bigint 'referee_id', null: false
    t.datetime 'completed_at', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['referee_id'], name: 'index_referrals_on_referee_id', unique: true
    t.index ['referrer_id'], name: 'index_referrals_on_referrer_id'
  end

  create_table 'users', charset: 'utf8mb4', collation: 'utf8mb4_0900_ai_ci', force: :cascade do |t|
    t.string 'first_name', null: false
    t.string 'last_name', null: false
    t.date 'birthdate', null: false
    t.integer 'zip_code', null: false
    t.string 'referral_code', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['referral_code'], name: 'index_users_on_referral_code', unique: true
  end

  add_foreign_key 'referrals', 'users', column: 'referee_id'
  add_foreign_key 'referrals', 'users', column: 'referrer_id'
end
