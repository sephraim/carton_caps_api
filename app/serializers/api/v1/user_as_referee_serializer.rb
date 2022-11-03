class Api::V1::UserAsRefereeSerializer < ApplicationSerializer
  attributes :referrer, :referees

  # Current user's referrer
  def referrer
    Api::V1::UserSerializer.new(referrer_user)
  end

  # Current user's referrer's referees (including current user)
  def referees
    referrer_user.referees.map { |r| Api::V1::UserSerializer.new(User.find(r.referee_id)) }
  end

  private

  # Find current user's referrer
  def referrer_user
    @referrer_user ||= User.find(object.referrer.referrer_id)
  end
end
