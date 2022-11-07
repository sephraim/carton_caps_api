# frozen_string_literal: true

require 'rails_helper'
require_relative '../../users/shared_examples/a_user'

shared_examples_for('a referral') do
  # :referrer
  it_behaves_like 'a user' do
    let(:user) { referrer }
    let(:user_json) { referral_json['referrer'] }
  end

  # :referee
  it_behaves_like 'a user' do
    let(:user) { referee }
    let(:user_json) { referral_json['referee'] }
  end

  # :completed_at
  it 'returns the time of completion' do
    expect(Time.parse(referral_json['completed_at'])).to eq(current_time)
  end
end
