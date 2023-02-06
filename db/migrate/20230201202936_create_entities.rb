# frozen_string_literal: true

class CreateEntities < ActiveRecord::Migration[6.1]
  def change
    create_table :entities do |t|
      t.string :name
      t.string :entity_type
      t.timestamps
      t.belongs_to :sentence, index: true, foreign_key: true
    end
  end
end
