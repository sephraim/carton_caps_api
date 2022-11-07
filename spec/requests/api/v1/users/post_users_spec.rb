# frozen_string_literal: true

require 'rails_helper'
require_relative 'shared_examples/a_user'

RSpec.describe 'Users', type: :request do
  describe 'POST /api/v1/users (#create)' do
    let(:new_user) { FactoryBot.build(:user) }
    let(:existing_user) { FactoryBot.create(:user) }

    context 'with valid parameters' do
      context 'without a referral code' do
        before do
          post '/api/v1/users', params:
            {
              first_name: new_user.first_name,
              last_name: new_user.last_name,
              birthdate: new_user.birthdate,
              zip_code: new_user.zip_code
            }
        end

        it_behaves_like 'a user' do
          let(:user) { new_user }
        end
      end

      context 'with a valid referral code' do
        before do
          post '/api/v1/users', params:
            {
              first_name: new_user.first_name,
              last_name: new_user.last_name,
              birthdate: new_user.birthdate,
              zip_code: new_user.zip_code,
              referral_code_used: existing_user.referral_code
            }
        end

        it_behaves_like 'a user' do
          let(:user) { new_user }
        end

        it 'creates a new referral' do
          referral = Referral.find_by(
            referrer_id: existing_user.id,
            referee_id: User.find(json['id']).id
          )
          expect(referral).to be_present
        end
      end
    end

    context 'with invalid parameters' do
      context 'with improper formatting' do
        before do
          post '/api/v1/users', params:
            {
              birthdate: '19999-09-09',
              zip_code: '999'
            }
        end

        it 'returns a unprocessable entity status' do
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

      context 'with nonexistant referral code' do
        before do
          post '/api/v1/users', params:
            {
              first_name: new_user.first_name,
              last_name: new_user.last_name,
              birthdate: new_user.birthdate,
              zip_code: new_user.zip_code,
              referral_code_used: 'BADCODE'
            }
        end

        it 'returns a unprocessable entity status' do
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

      context 'with referral code that has already reached max number of uses' do
        let(:max_num_referees) { 10 }
        let(:referrer) { existing_user }
        let(:referees) { FactoryBot.create_list(:user, max_num_referees) }

        before do
          referees.each do |referee|
            Referral.create(referrer_id: referrer.id, referee_id: referee.id)
          end

          post '/api/v1/users', params:
            {
              first_name: new_user.first_name,
              last_name: new_user.last_name,
              birthdate: new_user.birthdate,
              zip_code: new_user.zip_code,
              referral_code_used: referrer.referral_code
            }
        end

        it 'returns a unprocessable entity status' do
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
  end
end
