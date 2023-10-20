# frozen_string_literal: true

class LeaveRequest < ApplicationRecord
  after_initialize :set_defaults
  belongs_to :user

  def set_defaults
    status = "pending"
  end
end
