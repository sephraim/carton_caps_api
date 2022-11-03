class Api::V1::UserAsReferrerSerializer < ApplicationSerializer
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
