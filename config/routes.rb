Rails.application.routes.draw do
  root to: 'static_pages#index'

  get 'index', to: 'static_pages#index', as: :static_pages_index

  get 'rules', to: 'static_pages#rules', as: :static_pages_rules

  get 'help', to: 'static_pages#help', as: :static_pages_help

  get 'donate', to: 'static_pages#donate', as: :static_pages_donate

  get 'dynmap', to: 'static_pages#dynmap', as: :static_pages_dynmap

  get 'dynmap_inside', to: 'static_pages#dynmap_inside', as: :static_pages_dynmap_inside
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
