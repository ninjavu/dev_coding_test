# frozen_string_literal: true

class SentencesController < ApplicationController
  include Pagy::Backend
  before_action :set_sentence, except: :index

  def index
    @pagy, @sentences = pagy(Sentence.includes(:entities), page: params[:page])
  end

  def edit; end

  def update
    if @sentence.update(sentence_params)
      redirect_to action: :index, status: :see_other, page: params[:page]
    else
      render action: :edit, status: 422
    end
  end

  private

  def sentence_params
    params.require(:sentence).permit(:content)
  end

  def set_sentence
    @sentence = Sentence.find(params[:id])
  end
end
