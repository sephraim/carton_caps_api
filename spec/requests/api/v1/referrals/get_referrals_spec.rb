# frozen_string_literal: true

require 'rails_helper'
require_relative 'shared_examples/a_referral'

RSpec.describe 'Referrals', type: :request do
  describe 'GET /api/v1/referrals (#index)' do
    let(:num_referrals_per_referrer) { 5 }
    let(:num_referrals_total) { num_referrals_per_referrer * 2 }
    let(:referrals) do
      2.times.each_with_object([]) do |_, referrals|
        referrals << {
          referrer: FactoryBot.create(:user),
          referees: FactoryBot.create_list(:user, num_referrals_per_referrer)
        }
      end
    end
    let(:current_time) { Time.new(1999, 9, 9) }

    before do
      allow(Time).to receive(:now).and_return(current_time)

      referrals.each do |referral|
        referral[:referees].each do |referee|
          Referral.create(referrer_id: referral[:referrer].id, referee_id: referee.id)
        end
      end
    end

    context 'without params' do
      before do
        get '/api/v1/referrals'
      end

      it 'returns all referrals' do
        expect(json.size).to eq(num_referrals_total)
      end

      it_behaves_like 'a referral' do
        let(:referrer) { referrals.first[:referrer] }
        let(:referee) { referrals.first[:referees].first }
        let(:referral_json) { json.first }
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'with valid params' do
      context '?referrer_id' do
        before do
          get "/api/v1/referrals?referrer_id=#{referrals.first[:referrer].id}"
        end

        it 'returns referrals filtered by referrer ID' do
          expect(json.size).to eq(num_referrals_per_referrer)
        end

        it_behaves_like 'a referral' do
          let(:referrer) { referrals.first[:referrer] }
          let(:referee) { referrals.first[:referees].first }
          let(:referral_json) { json.first }
        end

        it 'returns status code 200' do
          expect(response).to have_http_status(:success)
        end
      end

      context '?referee_id' do
        before do
          get "/api/v1/referrals?referee_id=#{referrals.first[:referees].first.id}"
        end

        it 'returns referrals filtered by referee ID' do
          expect(json.size).to eq(1)
        end

        it_behaves_like 'a referral' do
          let(:referrer) { referrals.first[:referrer] }
          let(:referee) { referrals.first[:referees].first }
          let(:referral_json) { json.first }
        end

        it 'returns status code 200' do
          expect(response).to have_http_status(:success)
        end
      end
    end

    context 'with invalid params' do
      before do
        get '/api/v1/referrals?bad_param=no_good'
      end

      it 'returns all referrals' do
        expect(json.size).to eq(num_referrals_total)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(:success)
      end
    end
  end
end
