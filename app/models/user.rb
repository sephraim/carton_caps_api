class User < ApplicationRecord
  # NOTE: if a user gets destroyed then all its referrals also get destroyed
  has_one :referrer, class_name: 'Referral', foreign_key: 'referee_id', dependent: :destroy
  has_many :referees, class_name: 'Referral', foreign_key: 'referrer_id', dependent: :destroy
end
