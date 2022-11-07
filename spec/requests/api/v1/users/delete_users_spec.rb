# frozen_string_literal: true

require 'rails_helper'
require_relative 'shared_examples/a_user'

RSpec.describe 'Users', type: :request do
  describe 'DELETE /api/v1/users/:id (#destroy)' do
    let(:user) { FactoryBot.create(:user) }

    before do
      delete "/api/v1/users/#{user.id}"
    end

    it 'returns status code 204' do
      expect(response).to have_http_status(:no_content)
    end
  end
end
