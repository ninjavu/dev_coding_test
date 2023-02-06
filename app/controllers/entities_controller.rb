# frozen_string_literal: true

class EntitiesController < ApplicationController
  before_action :set_sentence

  def new
    @entity = @sentence.entities.new
  end

  def create
    @entity = @sentence.entities.create(entity_params)

    if @entity.valid?
      redirect_to sentences_url(page: params[:page]), status: :see_other
    else
      render action: :new, status: 422
    end
  end

  private

  def entity_params
    params.require(:entity).permit(:name, :entity_type)
  end

  def set_sentence
    @sentence = Sentence.find(params[:sentence_id])
  end
end
