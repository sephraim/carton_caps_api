class Api::V1::UserSerializer < ApplicationSerializer
  attributes :id, :first_name, :last_name, :birthdate, :zip_code, :referral_code

  attribute :links do
    {
      self: api_v1_user_url(object),
      referrals: {
        referred_by: referrer_api_v1_user_url(object),
        referees: referees_api_v1_user_url(object)
      }
    }
  end
end
