# frozen_string_literal: true

Rails.application.routes.draw do
  resources :sentences do
    resources :entities
  end
end
