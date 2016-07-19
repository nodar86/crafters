Rails.application.routes.draw do
  root to: 'static_pages#index'

  get 'static_pages/index', to: 'static_pages#index', as: :static_pages_index

  get 'static_pages/rules', to: 'static_pages#rules', as: :static_pages_rules

  get 'static_pages/help', to: 'static_pages#help', as: :static_pages_help

  get 'static_pages/donate', to: 'static_pages#donate', as: :static_pages_donate

  get 'static_pages/dynmap', to: 'static_pages#dynmap', as: :static_pages_dynmap

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
