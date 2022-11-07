# frozen_string_literal: true

require 'rails_helper'

shared_examples_for('a user') do
  let(:user_json) { json }

  it 'returns the first name' do
    expect(user_json['first_name']).to eq(user.first_name)
  end

  it 'returns the last name' do
    expect(user_json['last_name']).to eq(user.last_name)
  end

  it 'returns the birthdate' do
    expect(user_json['birthdate']).to eq(user.birthdate.to_s)
  end

  it 'returns the zip code' do
    expect(user_json['zip_code']).to eq(user.zip_code)
  end

  it 'returns the referral code' do
    expect(user_json['referral_code']).to eq(User.find(user_json['id']).referral_code)
  end

  describe 'links' do
    let(:user_links) { user_json['links'] }

    it 'returns the self link' do
      expect(user_links['self']).to end_with(api_v1_user_path(id: user_json['id']))
    end

    describe 'referrals' do
      let(:user_referrals) { user_links['referrals'] }

      it 'returns the referred by link' do
        expect(user_referrals['referred_by']).to end_with(referrer_api_v1_user_path(id: user_json['id']))
      end

      it 'returns the referees link' do
        expect(user_referrals['referees']).to end_with(referees_api_v1_user_path(id: user_json['id']))
      end
    end
  end
end
