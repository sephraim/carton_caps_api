class Api::V1::UserSerializer < ApplicationSerializer
  attributes :id, :first_name, :last_name, :birthdate, :zip_code, :referral_code
end