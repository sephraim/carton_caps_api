# frozen_string_literal: true

module Api
  module V1
    # User (w/r/t being a referrer) serializer
    class UserAsReferrerSerializer < ApplicationSerializer
      attributes :referrer, :referees

      # Current user
      def referrer
        Api::V1::UserSerializer.new(object)
      end

      # Current user's referees
      def referees
        object.referees.map { |r| Api::V1::UserSerializer.new(User.find(r.referee_id)) }
      end
    end
  end
end
