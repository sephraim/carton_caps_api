class UserSerializer < ApplicationSerializer
  attributes :id, :first_name, :last_name, :birthdate, :zip_code, :referral_code
  attribute :url

  def url
    user_url(object)
  end
end
