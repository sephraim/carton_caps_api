# frozen_string_literal: true

module Api
  module V1
    # Referral serializer
    class ReferralSerializer < ApplicationSerializer
      attributes :completed_at

      belongs_to :referrer, class_name: 'User'
      belongs_to :referee, class_name: 'User'
    end
  end
end
