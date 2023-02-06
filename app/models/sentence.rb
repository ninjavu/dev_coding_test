# frozen_string_literal: true

class Sentence < ApplicationRecord
  has_many :entities

  validates :content,
            presence: true,
            uniqueness: { case_sensitive: true }
end
