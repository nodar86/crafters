Rails.application.routes.draw do
  get 'static_pages/index'

  get 'static_pages/rules'

  get 'static_pages/help'

  get 'static_pages/donate'

  get 'static_pages/dynmap'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
