require "test_helper"

class Api::V1::UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get api_v1_users_url, as: :json
    assert_response :success
  end

  test "should create user" do
    assert_difference("User.count") do
      post api_v1_users_url, params: { user: { birthdate: @user.birthdate, first_name: @user.first_name, last_name: @user.last_name, referral_code: @user.referral_code, zip_code: @user.zip_code } }, as: :json
    end

    assert_response :created
  end

  test "should show user" do
    get api_v1_user_url(@user), as: :json
    assert_response :success
  end

  test "should update user" do
    patch api_v1_user_url(@user), params: { user: { birthdate: @user.birthdate, first_name: @user.first_name, last_name: @user.last_name, referral_code: @user.referral_code, zip_code: @user.zip_code } }, as: :json
    assert_response :success
  end

  test "should destroy user" do
    assert_difference("User.count", -1) do
      delete api_v1_user_url(@user), as: :json
    end

    assert_response :no_content
  end
end
