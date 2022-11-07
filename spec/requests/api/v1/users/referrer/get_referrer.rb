# frozen_string_literal: true

require 'rails_helper'
require_relative '../shared_examples/a_user'

RSpec.describe 'Referrer', type: :request do
  describe 'GET /api/v1/users/:id/referrer (#referrer)' do
    let(:referrer) { FactoryBot.create(:user) }
    let(:num_referees) { 2 }
    let(:referees) { FactoryBot.create_list(:user, num_referees) }

    before do
      referees.each do |referee|
        Referral.create(referrer_id: referrer.id, referee_id: referee.id)
      end

      get "/api/v1/users/#{referees.first.id}/referrer"
    end

    # :referrer
    it_behaves_like 'a user' do
      let(:user) { referrer }
      let(:user_json) { json['referrer'] }
    end

    # :referee
    it_behaves_like 'a user' do
      let(:user) { referees.first }
      let(:user_json) { json['referees'].first }
    end

    it 'returns all referees' do
      expect(json['referees'].size).to eq(num_referees)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end
  end
end
