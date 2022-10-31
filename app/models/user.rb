class User < ApplicationRecord
  has_one :referrer, class_name: 'Referral', foreign_key: 'referee_id'
  has_many :referees, class_name: 'Referral', foreign_key: 'referrer_id'
end
