# frozen_string_literal: true

require 'rails_helper'
require_relative 'shared_examples/a_user'

RSpec.describe 'Users', type: :request do
  describe 'GET /api/v1/users (#index)' do
    before do
      FactoryBot.create_list(:user, 10)
      get '/api/v1/users'
    end

    it 'returns all users' do
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /api/v1/users/:id (#show)' do
    let(:user) { FactoryBot.create(:user) }

    before do
      get "/api/v1/users/#{user.id}"
    end

    it_behaves_like 'a user'

    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end
  end
end
