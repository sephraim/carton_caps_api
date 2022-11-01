class Api::V1::ReferralSerializer < ApplicationSerializer
  attributes :completed_at

  belongs_to :referrer, class_name: 'User'
  belongs_to :referee, class_name: 'User'
end
