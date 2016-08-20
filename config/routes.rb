Rails.application.routes.draw do
# Application root
  root to: 'static_pages#index'

# Session management
  post 'sessions/create'
  get 'sessions/destroy'

# Static pages:
  get 'index', to: 'static_pages#index', as: :static_pages_index
  get 'szabalyzat', to: 'static_pages#rules', as: :static_pages_rules
  get 'segitseg', to: 'static_pages#help', as: :static_pages_help
  get 'tamogatas', to: 'static_pages#donate', as: :static_pages_donate
  get 'dynmap', to: 'static_pages#dynmap', as: :static_pages_dynmap
  get 'adatvedelmi-nyilatkozat', to: 'static_pages#privacy_policy', as: :static_pages_privacy_policy
  get 'bejelentkezes', to: 'static_pages#login', as: :static_pages_login
  
# User management:
  get 'regisztracio', to: 'users#new', as: :new_user
  post 'felhasznalok', to: 'felhasznalok#create', as: :create_user
  get 'felhasznalok/:id/edit', to: 'users#edit', as: :edit_user
  put 'felhasznalok/:id', to: 'users#update', as: :update_user
  get 'felhasznalok/:id', to: 'users#show', as: :show_user
  get 'email-visszaigazolasa/:token', to: 'users#confirm_email', as: 'confirm_email'
  get 'email-ujrakuldese/:id', to: 'users#confirm_email_resend', as: 'confirm_email_resend'
  get 'felhasznalok', to: 'users#index', as: :index_users

# Donations
  get 'tamogatas', to: 'donations#index', as: :donations
  get 'tamogatas/new', to: 'donations#new', as: :new_donation
  post 'donations', to: 'donations#create', as: :create_donation
  get 'tamogatas/:id', to: 'donations#show', as: :show_donation
  get 'tamogatas/:id/edit', to: 'donations#edit', as: :edit_donation
  put 'tamogatas/:id', to: 'donations#update', as: :update_donation
  delete 'tamogatas/:id', to: 'donations#destroy', as: :destroy_donation

# Whitelist
  get 'whitelist', to: 'users#whitelist_show', as: :whitelist
  post 'whitelist', to: 'users#whitelist_apply', as: :whitelist_apply

# Events
  get 'eventek', to: 'events#index', as: :events
  get 'event/new', to: 'events#new', as: :new_event
  post 'eventek', to: 'events#create', as: :create_event
  get 'eventek/:id/edit', to: 'events#edit', as: :edit_event
  put 'eventek/:id', to: 'events#update', as: :update_event
  get 'event/:id', to: 'events#show', as: :show_event
  delete 'event/:id', to: 'events#destroy', as: :destroy_event
  post 'eventek/:id/apply', to: 'events#apply', as: :event_apply
  post 'eventek/:id/resign', to: 'events#resign', as: :event_resign

# Admin
  get 'admin', to: 'admin#admin', as: :admin

# News
  get 'hirek', to: 'news#index', as: :news
  get 'hirek/new', to: 'news#new', as: :new_news
  post 'hirek', to: 'news#create', as: :create_news
  get 'hirek/:id/edit', to: 'news#edit', as: :edit_news
  put 'hirek/:id', to: 'news#update', as: :update_news
  get 'hirek/:id', to: 'news#show', as: :show_news
  delete 'hirek/:id', to: 'news#destroy', as: :destroy_news

end
