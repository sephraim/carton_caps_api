# frozen_string_literal: true

require 'test_helper'

module Api
  module V1
    class ReferralsControllerTest < ActionDispatch::IntegrationTest
      setup do
        @referral = referrals(:one)
      end

      test 'should get index' do
        get api_v1_referrals_url, as: :json
        assert_response :success
      end

      test 'should show referral' do
        get api_v1_referral_url(@referral), as: :json
        assert_response :success
      end

      test 'should destroy referral' do
        assert_difference('Referral.count', -1) do
          delete api_v1_referral_url(@referral), as: :json
        end

        assert_response :no_content
      end
    end
  end
end
