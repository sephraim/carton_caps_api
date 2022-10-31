require "test_helper"

class ReferralsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @referral = referrals(:one)
  end

  test "should get index" do
    get referrals_url, as: :json
    assert_response :success
  end

  test "should create referral" do
    assert_difference("Referral.count") do
      post referrals_url, params: { referral: { completed_at: @referral.completed_at, referee_id: @referral.referee_id, referrer_id: @referral.referrer_id } }, as: :json
    end

    assert_response :created
  end

  test "should show referral" do
    get referral_url(@referral), as: :json
    assert_response :success
  end

  test "should update referral" do
    patch referral_url(@referral), params: { referral: { completed_at: @referral.completed_at, referee_id: @referral.referee_id, referrer_id: @referral.referrer_id } }, as: :json
    assert_response :success
  end

  test "should destroy referral" do
    assert_difference("Referral.count", -1) do
      delete referral_url(@referral), as: :json
    end

    assert_response :no_content
  end
end
