# frozen_string_literal: true

class Entity < ApplicationRecord
  belongs_to :sentence

  validates :name, :entity_type, presence: true

  validates :name, uniqueness: {
    case_sensitive: false,
    scope: :sentence_id
  }

  validates :name, :entity_type, format: {
    with: /^[#{I18n.t("entity_pattern")}]*$/,
    message: I18n.t('entity_format_message'),
    multiline: true
  }
end
