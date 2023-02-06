# frozen_string_literal: true

module SentencesHelper
  include Pagy::Frontend

  def annotated_content(content, entities)
    tokens = content.split
    annotated_tokens = []

    tokens.each do |token|
      annotated_tokens << token
      entities.each do |entity|
        if token.gsub(/[^#{I18n.t("entity_pattern")}]/, '') == entity.name
          annotated_tokens[-1] = token.gsub(/\b#{entity.name}\b/, annotation_template(entity.name, entity.entity_type))
          break
        end
      end
    end

    annotated_tokens.join(' ')
  end

  def annotation_template(name, entity_type)
    ApplicationController.render(
      partial: 'shared/tag',
      locals: { name:, entity_type: }
    )
  end
end
