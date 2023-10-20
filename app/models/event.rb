# frozen_string_literal: true

class Event < ApplicationRecord
  validates :name, :date, :description, presence: true
end
