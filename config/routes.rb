Rails.application.routes.draw do
  resources :planos
  resources :organizacoes
  resources :aseguradoras
  devise_for :users, path: 'u'
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
