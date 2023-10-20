# frozen_string_literal: true

class Holiday < ApplicationRecord
  validates :name, :date, presence: true
end
