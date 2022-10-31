class User < ApplicationRecord
  has_many :referrer_referrals, class_name: 'Referral', foreign_key: 'referrer_id'
  has_many :referee_referrals, class_name: 'Referral', foreign_key: 'referee_id'
end
