class Referral < ApplicationRecord
  before_create :set_completed_at_time

  belongs_to :referrer, class_name: 'User'
  belongs_to :referee, class_name: 'User'

  def set_completed_at_time
    self.completed_at = Time.now
  end
end
