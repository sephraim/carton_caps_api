# frozen_string_literal: true

# User class
class User < ApplicationRecord
  REFERRAL_CODE_LENGTH = 6
  private_constant :REFERRAL_CODE_LENGTH

  before_create :create_unique_referral_code

  # NOTE: if a user gets destroyed then all its referrals also get destroyed
  has_one :referrer, class_name: 'Referral', foreign_key: 'referee_id', dependent: :destroy
  has_many :referees, class_name: 'Referral', foreign_key: 'referrer_id', dependent: :destroy

  private

  def create_unique_referral_code
    loop do
      self.referral_code = rand(36**REFERRAL_CODE_LENGTH).to_s(36).upcase
      break unless self.class.exists?(referral_code:)
    end
  end
end
